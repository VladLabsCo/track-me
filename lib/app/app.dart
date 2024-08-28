import 'package:flutter/material.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TrackMe',
      theme: theme.copyWith(
        textTheme: theme.textTheme.copyWith(),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final theme = ThemeData(
  primaryColor: const Color(0xFFE00101),
  scaffoldBackgroundColor: const Color(0xFFFBFBFB),
);
