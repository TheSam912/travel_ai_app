import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_app/screens/profile_screen.dart';
import 'package:travel_ai_app/screens/suggestion_screen.dart';
import 'package:travel_ai_app/screens/detail_screen.dart';
import 'package:travel_ai_app/screens/home_screen.dart';
import 'package:travel_ai_app/screens/main_screen.dart';
import 'package:travel_ai_app/screens/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorExploreKey = GlobalKey<NavigatorState>(debugLabel: 'shellExplore');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

Widget myTransition(child, animation) {
  return FadeTransition(opacity: CurveTween(curve: Curves.easeIn).animate(animation), child: child);
}

final GoRouter router =
    GoRouter(navigatorKey: _rootNavigatorKey, initialLocation: '/home', routes: <RouteBase>[
  GoRoute(
    path: '/detail_screen',
    name: "detail_screen",
    parentNavigatorKey: _rootNavigatorKey,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return CustomTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return myTransition(child, animation);
        },
      );
    },
  ),
  StatefulShellRoute.indexedStack(
      builder:
          (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(navigatorKey: _shellNavigatorHomeKey, routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: state.name,
                child: const HomeScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return myTransition(child, animation);
                },
              );
            },
          )
        ]),
        StatefulShellBranch(navigatorKey: _shellNavigatorExploreKey, routes: [
          GoRoute(
            path: '/explore',
            name: 'explore',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: state.name,
                child: SuggestionScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return myTransition(child, animation);
                },
              );
            },
          )
        ]),
        StatefulShellBranch(navigatorKey: _shellNavigatorProfileKey, routes: [
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: state.name,
                child: const ProfileScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return myTransition(child, animation);
                },
              );
            },
          )
        ]),
      ])
]);
