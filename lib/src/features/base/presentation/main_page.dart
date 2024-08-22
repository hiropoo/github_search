import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_search/src/components/my_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key, required this.child});

  final StatefulNavigationShell child; // ShellBranch

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AnimationControllersをhooksで管理
    final searchController = useAnimationController(
      duration: const Duration(milliseconds: 350),
    );
    final settingsController = useAnimationController(
      duration: const Duration(milliseconds: 350),
    );

    // 各アイコンがタップされた時にアニメーションを実行するメソッド
    void rotateIcon(int index) {
      if (index == 0) {
        searchController.forward(from: 0.0);
      } else if (index == 1) {
        settingsController.forward(from: 0.0);
      }
    }

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
              icon: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(searchController),
                child: const Icon(Icons.search),
              ),
              label: AppLocalizations.of(context)!.search,
            ),

            // 設定
            NavigationDestination(
              icon: RotationTransition(
                turns: Tween(begin: 0.0, end: 0.5).animate(settingsController),
                child: const Icon(Icons.settings),
              ),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
          selectedIndex: child.currentIndex,
          onDestinationSelected: (index) {
            if (index != child.currentIndex) {
              rotateIcon(index); // タップされたアイコンを回転させる
            }
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
