import 'dart:async';
import 'dart:developer' as dev;

import 'package:bitsgap/app/app_theme_mode/app_theme_mode.dart';
import 'package:bitsgap/app/app_theme_mode/app_theme_mode_settings.dart';
import 'package:bitsgap/app/restart_widget.dart';
import 'package:bitsgap/core/di/di.dart';
import 'package:bitsgap/core/di/di_get_it_implementation.dart';
import 'package:bitsgap/core/di/register_app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> mainShared(
  Widget Function(DI di) onReady,
) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        Zone.current.handleUncaughtError(
          errorDetails.exception,
          errorDetails.stack ?? StackTrace.empty,
        );
      };

      final di = DiGetItImplementation();
      await registerAppDependencies(di);

      runApp(
        RestartWidget(
          child: ChangeNotifierProvider.value(
            value: AppThemeMode(di<AppThemeModeSettings>().themeMode),
            child: onReady(di),
          ),
          onBeforeRestart: () async {
            await di.reset();
            await registerAppDependencies(di);
          },
        ),
      );
    },
    (error, StackTrace stackTrace) {
      dev.log(
        'An unhandled error!',
        error: error,
        stackTrace: stackTrace,
      );
    },
  );
}
