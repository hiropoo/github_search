import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_search/src/components/search_list_tile.dart';
import 'package:github_search/src/components/search_textfield.dart';
import 'package:github_search/src/features/search/presentation/repository_info_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final repositoryList = ref.watch(repositoryInfoListNotifierProvider);
    final repositoryListNotifier = ref.read(repositoryInfoListNotifierProvider.notifier);

    final scrollController = useScrollController();

    // スクロール位置を監視して、末尾に達したら次のページを取得する
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        repositoryListNotifier.fetchNextPage();
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          // 検索バー
          SearchTextfield(
            controller: searchController,
            onSubmitted: (query) async {
              if (query.isEmpty) {
                return;
              }

              // 検索をリセットして新しいクエリを実行
              repositoryListNotifier.reset();
              await repositoryListNotifier.searchRepositories(query);
            },
          ),

          // 検索結果
          repositoryList.when(
            data: (repositoryInfoList) {
              return Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: repositoryInfoList.length,
                  itemBuilder: (context, index) {
                    return SearchListTile(
                      repositoryInfo: repositoryInfoList[index],
                    );
                  },
                ),
              );
            },
            error: (error, stackTrace) {
              return Text('Error: $error');
            },
            loading: () {
              return const Expanded(child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    );
  }
}
