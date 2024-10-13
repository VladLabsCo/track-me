import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';

class ActivityStatsView extends StatelessWidget {
  const ActivityStatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Options',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            TmButton(
              label: 'Manage Activities',
              onPressed: () {},
              outlined: true,
            ),
          ],
        ),
      ),
    );
  }
}
