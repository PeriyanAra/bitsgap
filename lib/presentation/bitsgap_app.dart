import 'package:auto_route/auto_route.dart';
import 'package:bitsgap/app/app_theme_mode/app_theme_mode.dart';
import 'package:bitsgap/core/di/di.dart';
import 'package:bitsgap/presentation/auth.dart';
import 'package:bitsgap/presentation/theme/bitsgap_theme.dart';
import 'package:bitsgap/presentation/ui_kit/ui_kit.dart';
import 'package:bitsgap/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class BitsgapApp extends StatefulWidget {
  const BitsgapApp({
    super.key,
    required this.di,
  });

  final DI di;

  @override
  State<BitsgapApp> createState() => _BitsgapAppAppState();
}

class _BitsgapAppAppState extends State<BitsgapApp> {
  late final AppRouter _appRouter;
  late final AuthMobx _authMobx;

  @override
  void initState() {
    super.initState();

    _appRouter = AppRouter();
    _authMobx = widget.di();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => _authMobx,
      child: BitsgapSnackBarNotifier(
        child: Observer(
          builder: (context) {
            final isAuthenticated = _authMobx.isAuthenticated;
    
            return MaterialApp.router(
              title: 'Bitsgap',
              routerDelegate: AutoRouterDelegate.declarative(
                _appRouter,
                routes: (_) => isAuthenticated
                    ? [const AuthenticatedRoute()]
                    : [const AuthenticationRoute()],
              ),
              routeInformationParser: _appRouter.defaultRouteParser(),
              theme: BitsgapTheme.light(),
              darkTheme: BitsgapTheme.dark(),
              debugShowCheckedModeBanner: false,
              themeMode: context.watch<AppThemeMode>().themeMode,
            );
          },
        ),
      ),
    );
  }
}
