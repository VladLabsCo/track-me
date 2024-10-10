import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/features/activity_timer/activity_timer.dart';
import 'package:track_me/app/features/home/providers/home_provider.dart';

class HomeAnimatedSwitcher extends ConsumerWidget {
  const HomeAnimatedSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        final slideTransition = SlideTransition(
          position: Tween<Offset>(
            begin: child.key == const ValueKey(HomeState.stats())
                ? const Offset(1, 0)
                : const Offset(-1, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );

        final fadeTransition = FadeTransition(
          opacity: curvedAnimation,
          child: slideTransition,
        );

        return fadeTransition;
      },
      child: homeState.when(
        timer: () => const ActivityTimer(
          key: ValueKey(HomeState.timer()),
        ),
        stats: () => const Placeholder(
          key: ValueKey(HomeState.stats()),
        ),
      ),
    );
  }
}
