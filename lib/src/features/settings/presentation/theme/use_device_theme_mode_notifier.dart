import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'use_device_theme_mode_notifier.g.dart';

@riverpod
class UseDeviceTheme extends _$UseDeviceTheme {
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    final bool useDeviceTheme = prefs.getBool('useDeviceTheme') ?? false;

    return useDeviceTheme;
  }

  // モバイルのテーマを利用するかどうかの切り替え
  void toggleUseDeviceTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('useDeviceTheme', state == const AsyncData(true) ? false : true);

    state = AsyncData(state == const AsyncData(true) ? false : true);
  }
}
