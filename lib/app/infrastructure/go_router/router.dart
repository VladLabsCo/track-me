import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/widgets/tm_auth_shell.dart';
import 'package:track_me/app/features/activity_targets/views/activity_target_form_view.dart';
import 'package:track_me/app/features/features.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    ShellRoute(
      builder: (context, state, child) => TmAuthShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardView(),
          routes: [
            GoRoute(
              path: 'new-type',
              builder: (context, state) => const NewActivityFormView(),
            ),
            GoRoute(
              path: 'type-management',
              builder: (context, state) => const ActivityManagementView(),
            ),
            GoRoute(
              path: 'new-manual-log',
              builder: (context, state) => const ManualActivityView(),
            ),
            // GoRoute(
            //   path: 'new-target',
            //   builder: (context, state) => const ActivityTargetFormView(),
            // ),
          ],
        ),
      ],
    ),
  ],
);
