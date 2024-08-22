import 'package:dio/dio.dart';
import 'package:github_search/src/features/search/domain/github_response.dart';
import 'package:github_search/src/utils/api_client.dart';

class GithubApiClient extends ApiClient {
  /// GithubResponseクラスを使用してリポジトリ情報の検索結果を返すメソッド
  Future<GithubResponse> searchRepositories(String query, {int page = 1}) async {
    try {
      final response = await dio.get(
        'https://api.github.com/search/repositories',
        queryParameters: {
          'q': query,
          'page': page,
        },
      );
      return GithubResponse.fromJson(response.data);
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            type: DioExceptionType.badResponse,
            error: 'Error Code :$statusCode',
          );
        default:
          throw Exception('An unexpected error occurred: ${e.message}');
      }
    }
  }
}
