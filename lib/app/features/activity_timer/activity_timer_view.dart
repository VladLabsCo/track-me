import 'package:flutter/cupertino.dart';
import 'package:track_me/app/features/activity_timer/widgets/activity_picker.dart';
import 'package:track_me/app/features/activity_timer/widgets/activity_timeline/activity_timeline.dart';
import 'package:track_me/app/features/activity_timer/widgets/timer/timer.dart';

class ActivityTimerView extends StatelessWidget {
  const ActivityTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ActivityPicker(),
        SizedBox(height: 20),
        Timer(),
        SizedBox(height: 40),
        ActivityTimeline(),
      ],
    );
  }
}
