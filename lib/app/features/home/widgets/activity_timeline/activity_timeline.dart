import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/features/home/helpers/group_activities.dart';
import 'package:track_me/app/features/home/providers/activity_provider.dart';
import 'package:track_me/app/features/home/providers/activity_type_provider.dart';
import 'package:track_me/app/features/home/widgets/activity_timeline/activity_timeline_tile.dart';

class ActivityTimeline extends ConsumerWidget {
  const ActivityTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(
      activityNotifierProvider.select((state) => state.activities),
    );
    final activityTypes = ref.watch(
      activityTypeNotifierProvider.select((state) => state.activityTypes),
    );

    final groupedActivitiesEntries =
        groupActivities(activities).entries.toList();

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final group in groupedActivitiesEntries)
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
