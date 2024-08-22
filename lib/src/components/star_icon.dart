import 'package:flutter/material.dart';
import 'package:github_search/src/constants/app_sizes.dart';

class StarIcon extends StatelessWidget {
  const StarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: Sizes.p4),
      width: Theme.of(context).textTheme.bodyMedium!.fontSize,
      height: Theme.of(context).textTheme.bodyMedium!.fontSize,
      decoration: BoxDecoration(
        color: Colors.yellow[600],
        borderRadius: BorderRadius.circular(Theme.of(context).textTheme.bodyMedium!.fontSize!),
      ),
      child: Icon(Icons.star_rounded, color: Theme.of(context).colorScheme.surface, size: Theme.of(context).textTheme.bodyMedium!.fontSize! * 0.9),
    );
  }
}
