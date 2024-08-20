import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_search/src/features/search/domain/owner.dart';

part 'repository_info.freezed.dart';
part 'repository_info.g.dart';

@freezed
class RepositoryInfo with _$RepositoryInfo {
  const factory RepositoryInfo({
    required String fullName,             // '作成者/リポジトリ名'
    required Owner owner,                 // リポジトリのオーナー情報
    required String htmlUrl,              // リポジトリのURL
    @Default('') String description,      // リポジトリの説明
    required int stargazersCount,         // Star数
    required int watchersCount,           // Watcher数
    required int forksCount,              // Fork数
    required int openIssuesCount,         // Issue数
    @Default('Unknown') String language,  // プロジェクト言語
  }) = _RepositoryInfo;

  factory RepositoryInfo.fromJson(Map<String, dynamic> json) => _$RepositoryInfoFromJson(json);
}
