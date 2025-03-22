import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/activity_management/widgets/activity_types_list.dart';

class ActivityManagementView extends StatelessWidget {
  const ActivityManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return TmScaffold.nested(
      title: 'Manage Activities',
      subtitle: 'Your activities (in development...)',
      body: const SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActivityTypesList(),
          ],
        ),
      ),
    );
  }
}
