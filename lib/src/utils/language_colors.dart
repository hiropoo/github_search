import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LanguageColors {
  static Map<String, Map<String, String>>? _colorMap;

  /// JSONファイルをロードして色マップを初期化する
  static Future<void> load() async {
    try {
      final jsonString = await rootBundle.loadString('assets/language_colors.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      _colorMap = jsonMap.map(
        (key, value) {
          // デフォルト値を設定し、型変換エラーを防ぐ
          final color = value['color']?.toString() ?? '0xFF000000';
          return MapEntry(key, {'color': color});
        },
      );
    } catch (e) {
      debugPrint('Error loading language colors: $e');
      _colorMap = {}; // エラー時は空のマップを設定
    }
  }

  /// 色マップを取得する
  Map<String, Map<String, String>> get colorMap {
    if (_colorMap == null) {
      throw StateError('LanguageColors has not been loaded');
    }
    return _colorMap!;
  }
}
