import 'package:github_search/src/features/search/domain/owner.dart';
import 'package:github_search/src/features/search/domain/repository_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_info_notifier.g.dart';

@riverpod
class RepositoryInfoNotifier extends _$RepositoryInfoNotifier {
  @override
  Future<List<RepositoryInfo>> build() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      const RepositoryInfo(
        fullName: 'C/c',
        owner: Owner(
          avatarUrl: 'https://avatars.githubusercontent.com/u/14101776?v=4',
        ),
        htmlUrl: '',
        description: 'Flutter makes it easy and fast to build beautiful apps for mobile and beyond.',
        stargazersCount: 100000,
        watchersCount: 10000,
        forksCount: 1000,
        openIssuesCount: 100,
        language: 'C',
      ),
      const RepositoryInfo(
        fullName: 'flutter/flutter',
        owner: Owner(
          avatarUrl: 'https://avatars.githubusercontent.com/u/14101776?v=4',
        ),
        htmlUrl: '',
        description: 'Flutter makes it easy and fast to build beautiful apps for mobile and beyond.',
        stargazersCount: 100000,
        watchersCount: 10000,
        forksCount: 1000,
        openIssuesCount: 100,
        language: 'Dart',
      ),
      const RepositoryInfo(
        fullName: 'Java/java',
        owner: Owner(
          avatarUrl: 'https://avatars.githubusercontent.com/u/14101776?v=4',
        ),
        htmlUrl: '',
        description: 'Flutter makes it easy and fast to build beautiful apps for mobile and beyond.',
        stargazersCount: 100000,
        watchersCount: 10000,
        forksCount: 1000,
        openIssuesCount: 100,
        language: 'Java',
      ),
      const RepositoryInfo(
        fullName: 'flutter/flutter',
        owner: Owner(
          avatarUrl: 'https://avatars.githubusercontent.com/u/14101776?v=4',
        ),
        htmlUrl: '',
        description: 'Flutter makes it easy and fast to build beautiful apps for mobile and beyond.',
        stargazersCount: 100000,
        watchersCount: 10000,
        forksCount: 1000,
        openIssuesCount: 100,
        language: 'Dart',
      ),
      const RepositoryInfo(
        fullName: 'flutter/flutter',
        owner: Owner(
          avatarUrl: 'https://avatars.githubusercontent.com/u/14101776?v=4',
        ),
        htmlUrl: '',
        description: 'Flutter makes it easy and fast to build beautiful apps for mobile and beyond.',
        stargazersCount: 100000,
        watchersCount: 10000,
        forksCount: 1000,
        openIssuesCount: 100,
        language: 'Dart',
      ),
    ];
  }
}
