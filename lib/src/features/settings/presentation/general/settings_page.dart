import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_search/src/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // アプリのバージョンを取得
    final fromPlatform = useMemoized(PackageInfo.fromPlatform);
    final snapshot = useFuture(fromPlatform);
    if (!snapshot.hasData) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      body: SettingsList(
        darkTheme: SettingsThemeData(
          settingsListBackground: Theme.of(context).colorScheme.surface,
          settingsSectionBackground: Theme.of(context).colorScheme.surfaceContainer,
        ),
        lightTheme: SettingsThemeData(
          settingsListBackground: Theme.of(context).colorScheme.surface,
          settingsSectionBackground: Theme.of(context).colorScheme.surfaceContainer,
        ),
        platform: DevicePlatform.iOS,
        sections: [
          // アプリの外観設定
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.appAppearance),
            tiles: [
              // ダークモードの切り替え
              SettingsTile.switchTile(
                leading: const Icon(Icons.brightness_4),
                title: Text(AppLocalizations.of(context)!.darkMode),
                initialValue: false,
                onToggle: (value) {},
              ),

              // 端末のテーマ設定を使うかどうか
              SettingsTile.switchTile(
                leading: const Icon(Icons.app_settings_alt_rounded),
                title: Text(AppLocalizations.of(context)!.useDeviceTheme),
                initialValue: false,
                onToggle: (value) {},
              ),

              // 言語設定
              SettingsTile(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.language),
                value: const Row(
                  children: [
                    Text(
                      'English',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Icon(color: Colors.grey, Icons.keyboard_arrow_right),
                  ],
                ),
                onPressed: (context) => context.goNamed(AppRoute.language.name),
              ),
            ],
          ),

          // アプリについて
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.aboutApp),
            tiles: <SettingsTile>[
              // バージョン情報
              SettingsTile(
                leading: const Icon(Icons.info),
                title: Text(AppLocalizations.of(context)!.version),
                value: Text("${snapshot.data?.version}"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
