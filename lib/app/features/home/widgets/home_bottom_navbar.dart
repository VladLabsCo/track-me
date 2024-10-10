import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/features/home/providers/home_provider.dart';

class HomeBottomNavbar extends ConsumerWidget {
  const HomeBottomNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);

    return BottomAppBar(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: 70,
      child: Row(
        children: [
          _HomeBottomNavbarButton(
            icon: CupertinoIcons.timer,
            isActive: homeState is TimerHome,
            onPressed: ref.read(homeNotifierProvider.notifier).goTimer,
          ),
          _HomeBottomNavbarButton(
            icon: Icons.bar_chart_rounded,
            isActive: homeState is StatsHome,
            onPressed: ref.read(homeNotifierProvider.notifier).goStats,
          ),
        ],
      ),
    );
  }
}

class _HomeBottomNavbarButton extends ConsumerWidget {
  const _HomeBottomNavbarButton({
    required this.isActive,
    required this.icon,
    required this.onPressed,
  });

  final bool isActive;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        opacity: isActive ? 1 : 0.8,
        child: TextButton(
          style: IconButton.styleFrom(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(6),
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: onPressed,
          child: Icon(
            icon,
            size: 34,
            color: isActive ? Theme.of(context).primaryColor : null,
          ),
        ),
      ),
    );
  }
}
