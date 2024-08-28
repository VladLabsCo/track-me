import 'package:go_router/go_router.dart';
import 'package:track_me/app/features/features.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Home(),
    ),
  ],
);
