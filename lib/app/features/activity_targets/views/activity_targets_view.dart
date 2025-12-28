import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/activity_targets/widgets/activity_target_list.dart';
import 'package:track_me/app/features/activity_targets/widgets/activity_targets_actions.dart';

class ActivityTargetsView extends StatelessWidget {
  const ActivityTargetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return TmPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ActivityTargetActions(),
          const SizedBox(height: 20),
          Text('Your targets', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 20),
          const ActivityTargetList(),
        ],
      ),
    );
  }
}
