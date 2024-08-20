import 'package:flutter/material.dart';
import 'package:github_search/src/components/language_color_icon.dart';
import 'package:github_search/src/components/star_icon.dart';
import 'package:github_search/src/constants/app_sizes.dart';
import 'package:github_search/src/features/search/domain/repository_info.dart';

class SearchListTile extends StatelessWidget {
  const SearchListTile({super.key, required this.repositoryInfo});

  final RepositoryInfo repositoryInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      // 色設定
      color: Theme.of(context).colorScheme.surfaceContainer,
      shadowColor: Theme.of(context).colorScheme.onPrimary,

      margin: const EdgeInsets.symmetric(horizontal: Sizes.p16, vertical: Sizes.p4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),

        // カードをタップしたときの処理
        onTap: () {},

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p16, vertical: Sizes.p4),

          // タイトル、サブタイトル、言語、スター数を表示
          child: ListTile(
            contentPadding: EdgeInsets.zero,

            // リポジトリ名
            title: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(Sizes.p8),
                ),
                child: Text(
                  repositoryInfo.fullName.isEmpty ? '---' : repositoryInfo.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // 説明と言語、スター数
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  repositoryInfo.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LanguageColorIcon(
                      language: repositoryInfo.language,
                    ),
                    Text(repositoryInfo.language),
                    gapW8,
                    const StarIcon(),
                    Text(repositoryInfo.stargazersCount.toString()),
                  ],
                ),
              ],
            ),

            // 矢印アイコン
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
        ),
      ),
    );
  }
}
