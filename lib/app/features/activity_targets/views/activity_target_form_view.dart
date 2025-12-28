import 'package:flutter/material.dart';
import 'package:track_me/app/core/widgets/tm_scaffold.dart';
import 'package:track_me/app/features/activity_targets/widgets/activity_target_form.dart';

class ActivityTargetFormView extends StatelessWidget {
  const ActivityTargetFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return TmScaffold.nested(
      title: 'New target',
      subtitle: 'Create a new target for one of your activities.',
      body: const ActivityTargetForm(),
    );
  }
}
