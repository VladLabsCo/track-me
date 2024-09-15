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
        textTheme: GoogleFonts.latoTextTheme(theme.textTheme)
            .copyWith(
              titleSmall: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              labelMedium: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              bodySmall: TextStyle(
                fontSize: 15,
                color: Colors.white.withAlpha(180),
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
  dialogBackgroundColor: const Color(0xFF202122),
);
