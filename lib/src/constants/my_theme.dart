import 'package:flutter/material.dart';

// ライトテーマ
ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    // メインカラー
    primary: Color(0xffd4eaf7),
    onPrimary: Color(0xff3b3c3d),

    // アクセント1
    secondary: Color(0xff71c4ef),
    onSecondary: Color(0xff3b3c3d),

    // アクセント2
    tertiary: Color(0xff00668c),
    onTertiary: Color(0xff3b3c3d),

    // エラー
    error: Color.fromARGB(255, 161, 67, 67),
    onError: Color.fromARGB(255, 211, 211, 211),

    // 背景
    surface: Color(0xfffffefb),
    onSurface: Color(0xff1d1c1c),
    surfaceContainer: Color(0xfff5f4f1),
  ),
);

// ダークテーマ
ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    // メインカラー
    primary: Color(0xff1F3A5F),
    onPrimary: Color(0xffacc2ef),

    // アクセント1
    secondary: Color(0xff3D5A80),
    onSecondary: Color(0xffacc2ef),

    // アクセント2
    tertiary: Color(0xffcee8ff),
    onTertiary: Color(0xffacc2ef),

    // エラー
    error: Color.fromARGB(255, 161, 67, 67),
    onError: Color.fromARGB(255, 211, 211, 211),

    // 背景
    surface: Color(0xff0f1c2e),
    onSurface: Color(0xffe0e0e0),
    surfaceContainer: Color(0xff1f2b3e),
  ),
);
