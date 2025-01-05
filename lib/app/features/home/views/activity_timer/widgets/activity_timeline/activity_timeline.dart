import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/home/views/activity_timer/helpers/group_activities.dart';
import 'package:track_me/app/features/home/views/activity_timer/widgets/activity_timeline/activity_timeline_tile.dart';

class ActivityTimeline extends ConsumerWidget {
  const ActivityTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(
      activityNotifierProvider.select((state) => state.activities),
    );
    final activityTypes = ref.watch(
      activityTypeNotifierProvider.select((state) => state.types),
    );

    final groupedActivities = groupActivities(activities);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (groupedActivities.isEmpty)
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'New week, new hustle...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )
            else
              for (final group in groupedActivities)
                if (group.value.isNotEmpty) ...[
                  Text(group.key),
                  const SizedBox(
                    height: 10,
                  ),
                  for (final activity in group.value) ...[
                    ActivityTimelineTile(
                      activity: activity,
                      activityType: activityTypes.firstWhere(
                        (activityType) =>
                            activityType.id == activity.activityTypeId,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
          ],
        ),
      ),
    );
  }
}
