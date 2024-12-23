import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

class ActivityTimelineTile extends StatelessWidget {
  const ActivityTimelineTile({
    required this.activity,
    required this.activityType,
    super.key,
  });

  final Activity activity;
  final ActivityType activityType;

  @override
  Widget build(BuildContext context) {
    return TmCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            activityType.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          Text(
            tmTimeFormat(activity.duration),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
