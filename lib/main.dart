import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:github_search/src/constants/my_theme.dart';
import 'package:github_search/src/features/settings/presentation/theme/theme_mode_notifier.dart';
import 'package:github_search/src/features/settings/presentation/theme/use_device_theme_mode_notifier.dart';
import 'package:github_search/src/router/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  // スプラッシュ画面を表示
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // .envファイルの読み込み
  await dotenv.load(fileName: '.env');

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final themeMode = ref.watch(appThemeModeProvider).valueOrNull;
    final useDeviceTheme = ref.watch(useDeviceThemeProvider).valueOrNull;

    // 非同期の読み込みが完了したかどうかを確認
    if (themeMode == null || useDeviceTheme == null) {
      return const SizedBox.shrink(); // ローディング中の場合、空のウィジェットを返す
    }

    // ロードが完了したらスプラッシュ画面を削除
    FlutterNativeSplash.remove();

    return MaterialApp.router(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ja', ''), // 日本語
      ],
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: useDeviceTheme == true ? ThemeMode.system : themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
