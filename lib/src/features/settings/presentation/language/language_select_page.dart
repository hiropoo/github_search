import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:github_search/src/features/settings/domain/language.dart';
import 'package:github_search/src/features/settings/presentation/language/language_notifier.dart';
import 'package:github_search/src/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

class LanguageSelectPage extends HookConsumerWidget {
  const LanguageSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(languageNotifierProvider).valueOrNull;
    final languageNotifier = ref.read(languageNotifierProvider.notifier);

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
          // 言語選択
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.language),
            tiles: [
              // 英語
              SettingsTile(
                title: const Text('English'),
                trailing: selectedLocale == const Locale('en')
                    ? Icon(
                        Icons.check_rounded,
                        color: Theme.of(context).colorScheme.tertiary,
                      )
                    : null,
                onPressed: (context) {
                  languageNotifier.changeLanguage(Language.en);
                  context.goNamed(AppRoute.settings.name);
                },
              ),

              // 日本語
              SettingsTile(
                title: const Text('日本語'),
                trailing: selectedLocale == const Locale('ja')
                    ? Icon(
                        Icons.check_rounded,
                        color: Theme.of(context).colorScheme.tertiary,
                      )
                    : null,
                onPressed: (context) {
                  languageNotifier.changeLanguage(Language.ja);
                  context.goNamed(AppRoute.settings.name);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
