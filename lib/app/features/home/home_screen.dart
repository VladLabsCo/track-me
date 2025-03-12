import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/home/providers/home_provider.dart';
import 'package:track_me/app/features/home/widgets/home_animated_switcher.dart';
import 'package:track_me/app/features/home/widgets/home_bottom_navbar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TmScaffold(
      body: const HomeAnimatedSwitcher(),
      bottomNavigationBar: const HomeBottomNavbar(),
      floatingActionButton: ref.watch(homeNotifierProvider).when(
            timer: () => null,
            stats: () => const TmFab(),
          ),
    );
  }
}
