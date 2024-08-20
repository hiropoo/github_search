import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_search/src/features/search/domain/repository_info.dart';

part 'github_response.freezed.dart';
part 'github_response.g.dart';

@freezed
class GithubResponse with _$GithubResponse {
  const factory GithubResponse({
    required int totalCount,                // 検索結果の総数
    required bool incompleteResults,        // 検索結果が不完全かどうか  
    required List<RepositoryInfo> items,    // リポジトリ情報のリスト
  }) = _GithubResponse;

  factory GithubResponse.fromJson(Map<String, dynamic> json) => _$GithubResponseFromJson(json);
}
