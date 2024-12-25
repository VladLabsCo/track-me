import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_me/app/features/home/views/activity_stats/widgets/activity_actions.dart';
import 'package:track_me/app/features/home/views/activity_stats/widgets/activity_stats_list.dart';
import 'package:track_me/app/features/home/views/activity_stats/widgets/activity_stats_title.dart';

class ActivityStatsView extends StatelessWidget {
  const ActivityStatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ActivityActions(),
        SizedBox(height: 20),
        ActivityStatsTitle(),
        SizedBox(height: 20),
        ActivityStatsList(),
      ],
    );
  }
}
