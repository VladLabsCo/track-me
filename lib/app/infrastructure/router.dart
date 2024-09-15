import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/widgets/tm_auth_shell.dart';
import 'package:track_me/app/features/features.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    ShellRoute(
      builder: (context, state, child) => TmAuthShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Home(),
          routes: [
            GoRoute(
              path: 'activity-form',
              builder: (context, state) => const ActivityForm(),
            ),
          ],
        ),
      ],
    ),
  ],
);
