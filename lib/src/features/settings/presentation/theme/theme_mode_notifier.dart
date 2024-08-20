import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_mode_notifier.g.dart';

@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  Future<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme') ?? 'light';

    return theme == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  // テーマの切り替え
  void toggleTheme() async {
    // テーマを保存
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', state == const AsyncData(ThemeMode.light) ? 'dark' : 'light');

    state = AsyncData(state == const AsyncData(ThemeMode.light) ? ThemeMode.dark : ThemeMode.light);
  }
}
