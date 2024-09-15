import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/home/widgets/activity_picker.dart';
import 'package:track_me/app/features/home/widgets/timer/timer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const TmScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActivityPicker(),
          SizedBox(height: 20),
          Timer(),
        ],
      ),
    );
  }
}
