import 'package:bitsgap/app/app_theme_mode/app_theme_mode_settings.dart';
import 'package:bitsgap/core/di/dependencies.dart';
import 'package:bitsgap/core/di/di.dart';

class AppSharedDependencies extends Dependencies {
  @override
  Future<void> register(DI di) async {
    di.registerSingleton<AppThemeModeSettings>(
      await AppThemeModeSettings.createInstance(appKeyValueStorage: di()),
    );
  }
}
