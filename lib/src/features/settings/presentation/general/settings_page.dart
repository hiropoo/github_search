import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_search/src/features/settings/presentation/language/language_notifier.dart';
import 'package:github_search/src/features/settings/presentation/theme/theme_mode_notifier.dart';
import 'package:github_search/src/features/settings/presentation/theme/use_device_theme_mode_notifier.dart';
import 'package:github_search/src/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ダークモードのオンオフ
    final isDarkMode = ref.watch(appThemeModeProvider).valueOrNull == ThemeMode.dark;

    // 端末の設定を使うかどうか
    final useDeviceTheme = ref.watch(useDeviceThemeProvider).valueOrNull ?? false;

    // 選択された言語を取得
    final selectedLocale = ref.watch(languageNotifierProvider).valueOrNull ?? const Locale('en');
    String language = selectedLocale == const Locale('en') ? 'English' : '日本語';

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
                initialValue: isDarkMode,
                onToggle: (value) {
                  ref.read(appThemeModeProvider.notifier).toggleTheme();
                },
              ),

              // 端末のテーマ設定を使うかどうか
              SettingsTile.switchTile(
                leading: const Icon(Icons.app_settings_alt_rounded),
                title: Text(AppLocalizations.of(context)!.useDeviceTheme),
                initialValue: useDeviceTheme,
                onToggle: (value) {
                  ref.read(useDeviceThemeProvider.notifier).toggleUseDeviceTheme();
                },
              ),

              // 言語設定
              SettingsTile(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.language),
                value: Row(
                  children: [
                    Text(
                      language,
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                      ),
                    ),
                    const Icon(color: Colors.grey, Icons.keyboard_arrow_right),
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
                value: Text(
                  "${snapshot.data?.version}",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
