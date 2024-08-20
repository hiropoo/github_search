import 'package:dio/dio.dart';
import 'package:github_search/src/utils/env.dart';

class ApiClient {
  late Dio dio;

  ApiClient() {
    dio = Dio(_options());
  }

  BaseOptions _options() {
    return BaseOptions(
      baseUrl: 'https://api.github.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Accept': 'application/vnd.github+json',
        'Authorization': 'Bearer ${environment['api_key']}',
        'X-GitHub-Api-Version': '2022-11-28',
      },
    );
  }
}
