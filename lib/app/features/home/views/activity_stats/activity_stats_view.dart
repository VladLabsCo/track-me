import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_me/app/features/home/views/activity_timer/widgets/activity_title_actions.dart';

class ActivityStatsView extends StatelessWidget {
  const ActivityStatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActivityTitleActions(),
          ],
        ),
      ),
    );
  }
}
