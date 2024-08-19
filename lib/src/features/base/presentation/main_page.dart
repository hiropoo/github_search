import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:github_search/src/components/my_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key, required this.child});

  final StatefulNavigationShell child;  // ShellBranch

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MyAppBar> headers = <MyAppBar>[
      const MyAppBar(title: 'GitHub Search'),
      MyAppBar(title: AppLocalizations.of(context)!.settings),
    ];

    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: headers[child.currentIndex],

        body: child,

        // ボトムナビゲーションバー
        bottomNavigationBar: NavigationBar(
          indicatorColor: Theme.of(context).colorScheme.primary,
          destinations: [
            // 検索
            NavigationDestination(
              icon: const Icon(Icons.search),
              label: AppLocalizations.of(context)!.search,
            ),

            // 設定
            NavigationDestination(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
          selectedIndex: child.currentIndex,
          onDestinationSelected: (index) {
            child.goBranch(
              index,
              initialLocation: index == child.currentIndex,
            );
          },
        ),
      ),
    );
  }
}
