import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';

class ActivityTypesList extends ConsumerWidget {
  const ActivityTypesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityTypeState = ref.watch(activityTypeNotifierProvider);

    return Expanded(
      child: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (final activitiType in activityTypeState.types) ...[
                TmCard(child: Text(activitiType.name)),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
