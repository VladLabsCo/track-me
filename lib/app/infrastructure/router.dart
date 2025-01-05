import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/widgets/tm_auth_shell.dart';
import 'package:track_me/app/features/features.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => TmAuthShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'new-type',
              builder: (context, state) => const ActivityFormScreen(),
            ),
            GoRoute(
              path: 'type-management',
              builder: (context, state) => const ActivityManagementScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
