import 'package:flutter/cupertino.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/activity_timer/widgets/activity_timeline.dart';
import 'package:track_me/app/features/activity_timer/widgets/timer.dart';

class ActivityTimerView extends StatelessWidget {
  const ActivityTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const TmPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActivityPicker(),
          SizedBox(height: 20),
          Timer(),
          SizedBox(height: 40),
          ActivityTimeline(),
        ],
      ),
    );
  }
}
