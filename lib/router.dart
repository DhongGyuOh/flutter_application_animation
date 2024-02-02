import 'package:flutter_application_animation/screens/apple_watch_screen.dart';
import 'package:flutter_application_animation/screens/explicit_animation_screen.dart';
import 'package:flutter_application_animation/screens/implicit_animation_screen.dart';
import 'package:flutter_application_animation/screens/menu_screen.dart';
import 'package:flutter_application_animation/screens/screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(initialLocation: MenuScreen.routeURL, routes: [
  GoRoute(
      path: MenuScreen.routeURL,
      name: MenuScreen.routeName,
      builder: (context, state) => const MenuScreen(),
      routes: [
        GoRoute(
          path: CanvasScreen.routeURL,
          name: CanvasScreen.routeName,
          builder: (context, state) => const CanvasScreen(),
        ),
        GoRoute(
          path: ImplicitAnimationScreen.routeURL,
          name: ImplicitAnimationScreen.routeName,
          builder: (context, state) => const ImplicitAnimationScreen(),
        ),
        GoRoute(
          path: ExplicitAnimationScreen.routeURL,
          name: ExplicitAnimationScreen.routeName,
          builder: (context, state) => const ExplicitAnimationScreen(),
        ),
        GoRoute(
          path: AppleWatchScreen.routeURL,
          name: AppleWatchScreen.routeName,
          builder: (context, state) => const AppleWatchScreen(),
        ),
      ]),
]);
