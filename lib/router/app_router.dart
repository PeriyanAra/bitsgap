import 'package:auto_route/auto_route.dart';
import 'package:bitsgap/presentation.dart';

import 'package:bitsgap/router/authenticated_screen.dart';
import 'package:bitsgap/router/authentication_screen.dart';
import 'package:bitsgap/router/route_paths.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: RoutePaths.authentication,
          page: AuthenticationRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: RoutePaths.auth,
              page: AuthAnimatedRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: RoutePaths.authenticated,
          page: AuthenticatedRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: RoutePaths.profile,
              page: ProfileRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: RoutePaths.authAnimated,
          page: AuthAnimatedRoute.page,
        ),
      ];
}
