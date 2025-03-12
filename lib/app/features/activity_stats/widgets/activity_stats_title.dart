import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';

class ActivityStatsTitle extends ConsumerWidget {
  const ActivityStatsTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref
        .watch(userNotifierProvider)
        .maybeWhen(orElse: () => '', logged: (name) => name);

    return Text(
      'You are doing great, $userName!',
      style: const TextStyle(
        height: 1,
        fontSize: 26,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
