import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/manual_activity/widgets/manual_activity_form.dart';

class ManualActivityView extends StatelessWidget {
  const ManualActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return TmScaffold.nested(
      title: 'Add log manually',
      subtitle:
          'Provide required the information to add an activity log manually.',
      body: const ManualActivityForm(),
    );
  }
}
