import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:github_search/src/constants/app_sizes.dart';
import 'package:github_search/src/features/search/domain/repository_info.dart';

enum DetailsCardType {
  language,
  stars,
  watcher,
  forks,
  issue,
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key, required this.type, required this.repositoryInfo});

  final DetailsCardType type;
  final RepositoryInfo repositoryInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p24, vertical: Sizes.p12),
      child: Row(
        children: [
          _getIcon(),
          gapW16,
          Text(
            _getTypeText(context),
          ),
          const Spacer(),
          Text(
            _getText(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
            ),
          ),
        ],
      ),
    );
  }

  Icon _getIcon() {
    switch (type) {
      case DetailsCardType.language:
        return const Icon(
          Icons.language,
          color: Colors.blue,
        );
      case DetailsCardType.stars:
        return const Icon(
          Icons.star,
          color: Colors.amber,
        );
      case DetailsCardType.watcher:
        return const Icon(
          Icons.remove_red_eye,
          color: Colors.green,
        );
      case DetailsCardType.forks:
        return const Icon(
          Icons.call_split,
          color: Colors.purple,
        );
      case DetailsCardType.issue:
        return const Icon(
          Icons.error_outline,
          color: Colors.red,
        );
    }
  }

  String _getTypeText(context) {
    switch (type) {
      case DetailsCardType.language:
        return AppLocalizations.of(context)!.repoLanguage;
      case DetailsCardType.stars:
        return AppLocalizations.of(context)!.repoStars;
      case DetailsCardType.watcher:
        return AppLocalizations.of(context)!.repoWatchers;
      case DetailsCardType.forks:
        return AppLocalizations.of(context)!.repoForks;
      case DetailsCardType.issue:
        return AppLocalizations.of(context)!.repoIssues;
    }
  }

  String _getText() {
    switch (type) {
      case DetailsCardType.language:
        return repositoryInfo.language;
      case DetailsCardType.stars:
        return repositoryInfo.stargazersCount.toString();
      case DetailsCardType.watcher:
        return repositoryInfo.watchersCount.toString();
      case DetailsCardType.forks:
        return repositoryInfo.forksCount.toString();
      case DetailsCardType.issue:
        return repositoryInfo.openIssuesCount.toString();
    }
  }
}
