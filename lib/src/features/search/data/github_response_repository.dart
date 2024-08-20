import 'package:github_search/src/features/search/domain/github_response.dart';
import 'package:github_search/src/features/search/service/github_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_response_repository.g.dart';

@riverpod
GithubResponseRepository githubResponseRepository(GithubResponseRepositoryRef ref) => GithubResponseRepository();

class GithubResponseRepository {
  /// APIを利用してリポジトリ情報の検索結果を返すメソッド
  Future<GithubResponse> searchRepositories(String query) async {
    final api = GithubApiClient();

    try {
      final response = await api.searchRepositories(query);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
