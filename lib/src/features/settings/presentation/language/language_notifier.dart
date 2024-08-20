import 'dart:ui';

import 'package:github_search/src/features/settings/domain/language.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_notifier.g.dart';

@riverpod
class LanguageNotifier extends _$LanguageNotifier {
  @override
  Future<Locale> build() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('language');

    if (language == 'ja') {
      return const Locale('ja');
    }

    return const Locale('en');
  }

  /// 言語を変更するメソッド
  Future<void> changeLanguage(Language language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language.name);

    switch (language) {
      case Language.en:
        state = const AsyncData(Locale('en'));
        break;
      case Language.ja:
        state = const AsyncData(Locale('ja'));
        break;
    }
  }
}
