import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/widgets/tm_fab.dart';

class DashboardFab extends StatelessWidget {
  const DashboardFab({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        reverseDuration: const Duration(milliseconds: 110),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.5),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: tabController.index == 1
            ? TmFab(
                key: const ValueKey('fab'),
                toolip: 'Add activity manually',
                onPressed: () => context.go('/new-manual-log'),
              )
            : null,
      ),
    );
  }
}
