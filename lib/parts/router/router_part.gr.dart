// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:sea_battle/parts/auth/auth_part.dart' as _i1;
import 'package:sea_battle/parts/game_session/game_session_part.dart' as _i4;
import 'package:sea_battle/parts/home/home_part.dart' as _i3;
import 'package:sea_battle/parts/router/router_part.dart' as _i2;
import 'package:sea_battle/parts/ships_alignment/ships_alignment_part.dart'
    as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    },
    AuthRouteRoot.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AuthScreenRoot(),
      );
    },
    BootRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BootScreen(),
      );
    },
    GameSessionRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.GameSessionScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    HomeRouteRoot.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreenRoot(),
      );
    },
    ShipsAlignmentRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ShipsAlignmentScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i6.PageRouteInfo<void> {
  const AuthRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AuthScreenRoot]
class AuthRouteRoot extends _i6.PageRouteInfo<void> {
  const AuthRouteRoot({List<_i6.PageRouteInfo>? children})
      : super(
          AuthRouteRoot.name,
          initialChildren: children,
        );

  static const String name = 'AuthRouteRoot';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BootScreen]
class BootRoute extends _i6.PageRouteInfo<void> {
  const BootRoute({List<_i6.PageRouteInfo>? children})
      : super(
          BootRoute.name,
          initialChildren: children,
        );

  static const String name = 'BootRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.GameSessionScreen]
class GameSessionRoute extends _i6.PageRouteInfo<void> {
  const GameSessionRoute({List<_i6.PageRouteInfo>? children})
      : super(
          GameSessionRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameSessionRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreenRoot]
class HomeRouteRoot extends _i6.PageRouteInfo<void> {
  const HomeRouteRoot({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRouteRoot.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouteRoot';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ShipsAlignmentScreen]
class ShipsAlignmentRoute extends _i6.PageRouteInfo<void> {
  const ShipsAlignmentRoute({List<_i6.PageRouteInfo>? children})
      : super(
          ShipsAlignmentRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShipsAlignmentRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
