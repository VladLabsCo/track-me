import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/activity_management/widgets/activity_types_list.dart';

class ActivityManagementScreen extends StatelessWidget {
  const ActivityManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TmScaffold.nested(
      title: 'Manage Activities',
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your activities (in development...)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            const ActivityTypesList(),
          ],
        ),
      ),
    );
  }
}
