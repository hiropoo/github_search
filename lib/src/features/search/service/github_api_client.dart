import 'package:dio/dio.dart';
import 'package:github_search/src/features/search/domain/github_response.dart';
import 'package:github_search/src/utils/api_client.dart';

class GithubApiClient extends ApiClient {
  /// GithubResponseクラスを使用してリポジトリ情報の検索結果を返すメソッド
  Future<GithubResponse> searchRepositories(String query) async {
    try {
      final response = await dio.get(
        'https://api.github.com/search/repositories',
        queryParameters: {'q': query},
      );
      return GithubResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
