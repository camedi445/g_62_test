import 'package:flutter/material.dart';
import 'package:g_62_test/ui/detail/DetailScreen.dart';
import 'package:g_62_test/ui/home/home_screen.dart';
import 'package:g_62_test/ui/navigation/widgets/main_scaffold.dart';
import 'package:g_62_test/ui/pantalla2/pantalla2_screen.dart';
import 'package:g_62_test/ui/pantalla3/pantalla3_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/detail',
      name: 'detail',
      builder: (BuildContext context, GoRouterState state) {
        final detail = state.extra as dynamic;
        return DetailScreen(detail: detail);
      },
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return HomePage();
          },
        ),
        GoRoute(
          path: '/pantalla2',
          name: 'pantalla2',
          builder: (BuildContext context, GoRouterState state) {
            return Pantalla2Screen();
          },
        ),
        GoRoute(
          path: '/pantalla3',
          name: 'pantalla3',
          builder: (BuildContext context, GoRouterState state) {
            return Pantalla3Screen();
          },
        ),
      ],
    ),
  ],
);
