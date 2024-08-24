import 'package:flutter/material.dart';
import 'package:github_search/src/features/base/presentation/main_page.dart';
import 'package:github_search/src/features/search/domain/repository_info.dart';
import 'package:github_search/src/features/search/presentation/details/details_page.dart';
import 'package:github_search/src/features/search/presentation/search_page.dart';
import 'package:github_search/src/features/settings/presentation/general/settings_page.dart';
import 'package:github_search/src/features/settings/presentation/language/language_select_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _searchNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'search');
final _settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

enum AppRoute {
  search,
  details,
  settings,
  language,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/search',
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state, shellWidget) => MaterialPage(
            child: MainPage(
          child: shellWidget,
        )),
        branches: [
          StatefulShellBranch(
            navigatorKey: _searchNavigatorKey,
            routes: [
              GoRoute(
                path: '/search',
                name: AppRoute.search.name,
                builder: (context, state) => const SearchPage(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'details',
                    name: AppRoute.details.name,
                    builder: (context, state) => DetailsPage(repositoryInfo: state.extra as RepositoryInfo),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings',
                name: AppRoute.settings.name,
                builder: (context, state) => const SettingsPage(),
                routes: [
                  GoRoute(
                    path: 'language',
                    name: AppRoute.language.name,
                    builder: (context, state) => const LanguageSelectPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    ],
  );
}
