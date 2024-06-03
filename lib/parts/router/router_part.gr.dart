// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:sea_battle/parts/auth/auth_part.dart' as _i1;
import 'package:sea_battle/parts/game_session/game_session_part.dart' as _i5;
import 'package:sea_battle/parts/game_session_list/game_session_list_part.dart'
    as _i4;
import 'package:sea_battle/parts/home/home_part.dart' as _i3;
import 'package:sea_battle/parts/router/router_part.dart' as _i2;
import 'package:sea_battle/parts/settings/settings_part.dart' as _i6;
import 'package:sea_battle/parts/ships_alignment/ships_alignment_part.dart'
    as _i7;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    },
    AuthRouteRoot.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AuthScreenRoot(),
      );
    },
    BootRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BootScreen(),
      );
    },
    GameSessionListRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.GameSessionListScreen(),
      );
    },
    GameSessionRoute.name: (routeData) {
      final args = routeData.argsAs<GameSessionRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.GameSessionScreen(
          key: args.key,
          gameSessionId: args.gameSessionId,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    HomeRouteRoot.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreenRoot(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SettingsScreen(),
      );
    },
    ShipsAlignmentRoute.name: (routeData) {
      final args = routeData.argsAs<ShipsAlignmentRouteArgs>(
          orElse: () => const ShipsAlignmentRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.ShipsAlignmentScreen(
          key: args.key,
          gameSessionId: args.gameSessionId,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i8.PageRouteInfo<void> {
  const AuthRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AuthScreenRoot]
class AuthRouteRoot extends _i8.PageRouteInfo<void> {
  const AuthRouteRoot({List<_i8.PageRouteInfo>? children})
      : super(
          AuthRouteRoot.name,
          initialChildren: children,
        );

  static const String name = 'AuthRouteRoot';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BootScreen]
class BootRoute extends _i8.PageRouteInfo<void> {
  const BootRoute({List<_i8.PageRouteInfo>? children})
      : super(
          BootRoute.name,
          initialChildren: children,
        );

  static const String name = 'BootRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.GameSessionListScreen]
class GameSessionListRoute extends _i8.PageRouteInfo<void> {
  const GameSessionListRoute({List<_i8.PageRouteInfo>? children})
      : super(
          GameSessionListRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameSessionListRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.GameSessionScreen]
class GameSessionRoute extends _i8.PageRouteInfo<GameSessionRouteArgs> {
  GameSessionRoute({
    _i9.Key? key,
    required String gameSessionId,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          GameSessionRoute.name,
          args: GameSessionRouteArgs(
            key: key,
            gameSessionId: gameSessionId,
          ),
          initialChildren: children,
        );

  static const String name = 'GameSessionRoute';

  static const _i8.PageInfo<GameSessionRouteArgs> page =
      _i8.PageInfo<GameSessionRouteArgs>(name);
}

class GameSessionRouteArgs {
  const GameSessionRouteArgs({
    this.key,
    required this.gameSessionId,
  });

  final _i9.Key? key;

  final String gameSessionId;

  @override
  String toString() {
    return 'GameSessionRouteArgs{key: $key, gameSessionId: $gameSessionId}';
  }
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreenRoot]
class HomeRouteRoot extends _i8.PageRouteInfo<void> {
  const HomeRouteRoot({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRouteRoot.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouteRoot';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SettingsScreen]
class SettingsRoute extends _i8.PageRouteInfo<void> {
  const SettingsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ShipsAlignmentScreen]
class ShipsAlignmentRoute extends _i8.PageRouteInfo<ShipsAlignmentRouteArgs> {
  ShipsAlignmentRoute({
    _i9.Key? key,
    String? gameSessionId,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ShipsAlignmentRoute.name,
          args: ShipsAlignmentRouteArgs(
            key: key,
            gameSessionId: gameSessionId,
          ),
          initialChildren: children,
        );

  static const String name = 'ShipsAlignmentRoute';

  static const _i8.PageInfo<ShipsAlignmentRouteArgs> page =
      _i8.PageInfo<ShipsAlignmentRouteArgs>(name);
}

class ShipsAlignmentRouteArgs {
  const ShipsAlignmentRouteArgs({
    this.key,
    this.gameSessionId,
  });

  final _i9.Key? key;

  final String? gameSessionId;

  @override
  String toString() {
    return 'ShipsAlignmentRouteArgs{key: $key, gameSessionId: $gameSessionId}';
  }
}
