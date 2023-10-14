import 'package:bitsgap/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppThemeModeSettings {
  AppThemeModeSettings._(this._appKeyValueStorage);

  final AppKeyValueStorage _appKeyValueStorage;
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _appKeyValueStorage.write(AppSettingsKey.themeMode.key, themeMode.name);
    _themeMode = themeMode;
  }

  static Future<AppThemeModeSettings> createInstance({
    required AppKeyValueStorage appKeyValueStorage,
  }) async {
    final instance = AppThemeModeSettings._(appKeyValueStorage);

    await instance._initializeAppThemeModeSettings();

    return instance;
  }

  Future<void> _initializeAppThemeModeSettings() async {
    var systemThemeMode = ThemeMode.light;
    final storedThemeMode = await _appKeyValueStorage.read<String>(AppSettingsKey.themeMode.key);

    if (SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark) {
      systemThemeMode = ThemeMode.dark;
    }

    _themeMode =
        storedThemeMode != null ? ThemeMode.values.byName(storedThemeMode) : systemThemeMode;
  }
}
