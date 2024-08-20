import 'package:flutter/material.dart';
import 'package:github_search/src/constants/app_sizes.dart';
import 'package:github_search/src/utils/language_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageColorIcon extends ConsumerWidget {
  const LanguageColorIcon({super.key, required this.language});

  final String language;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // LanguageColorsインスタンスを取得
    final languageColors = LanguageColors();
    final colorMap = languageColors.colorMap;

    // colorMapから指定された言語の色を取得
    final colorHex = colorMap[language]?['color'] ?? '0xFF0095d9'; // デフォルト色は青
    final color = Color(int.parse(colorHex));

    return Container(
      margin: const EdgeInsets.only(right: Sizes.p4),
      width: Theme.of(context).textTheme.bodyMedium!.fontSize,
      height: Theme.of(context).textTheme.bodyMedium!.fontSize,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Theme.of(context).textTheme.bodyMedium!.fontSize!),
      ),
      child: Icon(Icons.language, color: Theme.of(context).colorScheme.surface, size: Theme.of(context).textTheme.bodyMedium!.fontSize! * 0.8),
    );
  }
}
