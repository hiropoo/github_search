import 'package:flutter/material.dart';
import 'package:github_search/src/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Settings Page'),
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppRoute.language.name);
              },
              child: const Text('Go to Language Select'),
            ),
          ],
        ),
      ),
    );
  }
}
