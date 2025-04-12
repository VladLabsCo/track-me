import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TrackMe',
      theme: theme.copyWith(
        textTheme: GoogleFonts.latoTextTheme(theme.textTheme)
            .copyWith(
              titleSmall: const TextStyle(
                height: 1,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              labelMedium: const TextStyle(
                height: 1,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              labelSmall: const TextStyle(
                height: 1,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              bodyLarge: const TextStyle(
                height: 1,
                fontSize: 20,
              ),
              bodyMedium: const TextStyle(
                height: 1,
                fontSize: 18,
              ),
              bodySmall: const TextStyle(
                height: 1,
                fontSize: 16,
              ),
            )
            .apply(
              bodyColor: Colors.white,
            ),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final theme = ThemeData(
  primaryColor: const Color(0xFFF5004F),
  cardColor: const Color(0xFF202122),
  scaffoldBackgroundColor: const Color(0xFF0D0E0F),
  dialogTheme: const DialogThemeData(
    backgroundColor: Color(0xFF202122),
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    brightness: Brightness.dark,
  ),
);
