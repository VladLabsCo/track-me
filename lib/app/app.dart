import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TrackMe',
      theme: theme.copyWith(
        textTheme: GoogleFonts.latoTextTheme(theme.textTheme).copyWith(
          labelMedium: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final theme = ThemeData(
  primaryColor: const Color(0xFFF5004F),
  scaffoldBackgroundColor: const Color(0xFF0D0E0F),
);
