import 'package:github_search/src/features/search/data/github_response_repository.dart';
import 'package:github_search/src/features/search/domain/repository_info.dart';
import 'package:github_search/src/utils/list_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_info_notifier.g.dart';

@Riverpod(keepAlive: true)
class RepositoryInfoListNotifier extends _$RepositoryInfoListNotifier {
  int _page = 1; // 現在のページ番号
  bool _hasNextPage = false; // 次のページがあるかどうか
  String _currentQuery = '';
  bool _isFetching = false; // 重複リクエストを防ぐためのフラグ

  @override
  Future<List<RepositoryInfo>> build() async {
    return [];
  }

  /// 検索を実行するメソッド
  Future<void> searchRepositories(String query) async {
    _currentQuery = query;
    _page = 1; // 新しい検索時にページをリセット
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return _fetchRepositories();
    });
  }

  /// 実際にリポジトリデータを取得するメソッド
  Future<List<RepositoryInfo>> _fetchRepositories() async {
    final response = await ref.read(githubResponseRepositoryProvider).searchRepositories(_currentQuery, page: _page);

    // 次のページがあるかどうかを判定
    if (response.items.length < response.totalCount) {
      _hasNextPage = true;
    }

    return response.items;
  }

  /// 検索をリセットするメソッド
  void reset() {
    _page = 1;
    _hasNextPage = false;
    _currentQuery = '';

    state = const AsyncData([]);
  }

  /// 次のページを取得するメソッド
  Future<void> fetchNextPage() async {
    if (_isFetching || state.isLoading || !_hasNextPage) return; // 重複リクエストを防止
    _isFetching = true; // フェッチ中のフラグを設定

    final prevState = state;
    state = const AsyncLoading<List<RepositoryInfo>>().copyWithPrevious(state); // 現在の状態を保持

    try {
      _page++; // 次のページ番号にインクリメント
      final newItems = await _fetchRepositories();

      // 現在のリストに新しいリポジトリを追加
      state = prevState.whenData((existingItems) {
        // 既存のアイテムの末尾の100個
        final last100Items = existingItems.isNotEmpty ? existingItems.takeLast(100) : [];
        // 末尾の100個と新しいアイテムを結合
        return [...last100Items, ...newItems];
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      _isFetching = false; // フェッチ終了時にフラグをリセット
    }
  }
}
