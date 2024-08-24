import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_search/src/components/error_card.dart';
import 'package:github_search/src/components/search_list_tile.dart';
import 'package:github_search/src/components/search_loading_indicator.dart';
import 'package:github_search/src/components/search_textfield.dart';
import 'package:github_search/src/constants/app_sizes.dart';
import 'package:github_search/src/features/search/presentation/repository_info_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final repositoryList = ref.watch(repositoryInfoListNotifierProvider);
    final repositoryListNotifier = ref.read(repositoryInfoListNotifierProvider.notifier);

    // スクロール位置を監視して、末尾に達したら次のページを取得する
    final scrollController = useScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        repositoryListNotifier.fetchNextPage();
      }
    });

    // 検索バーから検索を実行するメソッド
    final onSubmitted = useCallback(
      (query) async {
        // 空文字やスペースのみの場合は何もしない
        if (query.isEmpty || query == ' ' || query == '　') {
          return;
        }

        // 検索をリセットして新しいクエリを実行
        repositoryListNotifier.reset();
        await repositoryListNotifier.searchRepositories(query);
      },
      [],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          // 検索バー
          SearchTextfield(
            controller: searchController,
            onSubmitted: onSubmitted,
          ),

          // 検索結果
          repositoryList.when(
            data: (repositoryInfoList) {
              return Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: repositoryInfoList.length + 1,
                  itemBuilder: (context, index) {
                    // 最後のアイテムでローディングインジケータを表示
                    if (index == repositoryInfoList.length) {
                      if (repositoryList.isLoading) {
                        return const Center(
                            child: Padding(
                          padding: EdgeInsets.all(Sizes.p32),
                          child: CircularProgressIndicator(),
                        ));
                      } else {
                        return const SizedBox.shrink();
                      }
                    }

                    return SearchListTile(
                      repositoryInfo: repositoryInfoList[index],
                    );
                  },
                ),
              );
            },
            error: (error, _) => ErrorCard(error: error),
            loading: () => const SearchLoadingIndicator(),
          ),
        ],
      ),
    );
  }
}
