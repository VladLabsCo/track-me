import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/features/home/providers/activity_provider.dart';
import 'package:track_me/app/features/home/providers/activity_type_provider.dart';
import 'package:track_me/app/features/home/widgets/activity_timeline/activity_timeline_tile.dart';

class ActivityTimeline extends ConsumerWidget {
  const ActivityTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(activityNotifierProvider);
    final activityTypes = ref.watch(
      activityTypeNotifierProvider.select((state) => state.activityTypes),
    );

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (final activity in activityState.activities) ...[
              ActivityTimelineTile(
                activity: activity,
                activityType: activityTypes.firstWhere(
                  (activityType) => activityType.id == activity.activityTypeId,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}
