part of 'router_part.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: BootRoute.page,
        ),
        AutoRoute(
          path: '/home',
          page: HomeRouteRoot.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: GameSessionRoute.page),
            AutoRoute(page: ShipsAlignmentRoute.page),
            AutoRoute(page: GameSessionListRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
        AutoRoute(
          path: '/auth',
          page: AuthRouteRoot.page,
          children: [
            AutoRoute(page: AuthRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
      ];
}
