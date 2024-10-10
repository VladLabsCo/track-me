import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/home/widgets/home_animated_switcher.dart';
import 'package:track_me/app/features/home/widgets/home_bottom_navbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const TmScaffold(
      body: HomeAnimatedSwitcher(),
      bottomNavigationBar: HomeBottomNavbar(),
    );
  }
}
