import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';

class ActivityTargetList extends ConsumerWidget {
  const ActivityTargetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityTargets = ref.watch(activityTargetProvider).targets;

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (activityTargets.isEmpty)
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Transform.rotate(
                      angle: pi / 2.0,
                      child: Text(
                        ':(',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.white.withAlpha(180),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "You haven't set any target",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white.withAlpha(180),
                      ),
                    ),
                  ],
                ),
              )
            else
              for (final target in activityTargets) ...[
                Text(target.id),
                const SizedBox(height: 15),
              ],
          ],
        ),
      ),
    );
  }
}
