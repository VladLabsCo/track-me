import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';

class ActivityTypesList extends ConsumerWidget {
  const ActivityTypesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityTypeState = ref.watch(activityTypeNotifierProvider);

    Future<void> handleArchiveACtivity(String activityTypeId) async {
      await tmDialogConfirm(
        context: context,
        title: 'Archive activity',
        subtitle: 'Are you sure you want to archive this activity?',
        deny: 'No',
        accept: 'Yes',
        onAccepted: () {},
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (final activityType in activityTypeState.types) ...[
              TmCard(
                actions: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () => handleArchiveACtivity(activityType.id),
                  child: const Icon(
                    CupertinoIcons.archivebox,
                    size: 22,
                  ),
                ),
                child: Text(activityType.name),
              ),
              const SizedBox(height: 15),
            ],
          ],
        ),
      ),
    );
  }
}
