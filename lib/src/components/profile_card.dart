import 'package:flutter/material.dart';
import 'package:github_search/src/components/avatar_circle.dart';
import 'package:github_search/src/constants/app_sizes.dart';
import 'package:github_search/src/features/search/domain/repository_info.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.repositoryInfo});

  final RepositoryInfo repositoryInfo;

  @override
  Widget build(BuildContext context) {
    final ownerName = repositoryInfo.fullName.split('/').first;
    final ownerAvatarUrl = repositoryInfo.owner.avatarUrl;
    final repoName = repositoryInfo.fullName.split('/').last;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 250),
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainer,
        shadowColor: Theme.of(context).colorScheme.onPrimary,
        margin: const EdgeInsets.symmetric(horizontal: Sizes.p16, vertical: Sizes.p4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p16, vertical: Sizes.p4),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AvatarCircle(avatarUrl: ownerAvatarUrl),
                gapH8,
                Text(ownerName),
                const SizedBox(height: Sizes.p4),
                Text(
                  repoName,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(child: Text(repositoryInfo.description)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
