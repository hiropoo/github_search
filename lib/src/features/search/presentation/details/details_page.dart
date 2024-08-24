import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_search/src/components/details_card.dart';
import 'package:github_search/src/components/my_app_bar.dart';
import 'package:github_search/src/components/profile_card.dart';
import 'package:github_search/src/constants/app_sizes.dart';
import 'package:github_search/src/features/search/domain/repository_info.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.repositoryInfo});

  final RepositoryInfo repositoryInfo;

  @override
  Widget build(BuildContext context) {
    debugPrint('DetailsPage: ${repositoryInfo.htmlUrl}');
    return Scaffold(
      appBar: MyAppBar(title: repositoryInfo.fullName),
      body: Column(
        children: [
          ProfileCard(repositoryInfo: repositoryInfo),
          gapH16,

          // 言語、スター数、ウォッチャー数、フォーク数、イシュー数を表示
          DetailsCard(type: DetailsCardType.language, repositoryInfo: repositoryInfo),
          DetailsCard(type: DetailsCardType.stars, repositoryInfo: repositoryInfo),
          DetailsCard(type: DetailsCardType.watcher, repositoryInfo: repositoryInfo),
          DetailsCard(type: DetailsCardType.forks, repositoryInfo: repositoryInfo),
          DetailsCard(type: DetailsCardType.issue, repositoryInfo: repositoryInfo),

          gapH16,

          _GithubLinkButton(repositoryInfo: repositoryInfo),
        ],
      ),
    );
  }
}

/// GitHubをアプリ内で開くボタン
class _GithubLinkButton extends HookWidget {
  const _GithubLinkButton({required this.repositoryInfo});

  final RepositoryInfo repositoryInfo;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        launchUrl(Uri.parse(repositoryInfo.htmlUrl));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.viewOnGithub,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          gapW8,
          Icon(
            Icons.open_in_new,
            color: Theme.of(context).colorScheme.onPrimary,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize! + 4,
          ),
        ],
      ),
    );
  }
}
