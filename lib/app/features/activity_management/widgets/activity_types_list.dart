import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

class ActivityTypesList extends ConsumerWidget {
  const ActivityTypesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityTypeState = ref.watch(activityTypeNotifierProvider);

    final activeActivityTypes = <ActivityType>[];
    final archivedActivityTypes = <ActivityType>[];

    for (final activityType in activityTypeState.types) {
      if (activityType.isArchived) {
        archivedActivityTypes.add(activityType);
      } else {
        activeActivityTypes.add(activityType);
      }
    }

    Future<void> handleArchiveActivity(ActivityType activityType) async {
      await tmDialogConfirm(
        context: context,
        title:
            activityType.isArchived ? 'Restore activity' : 'Archive activity',
        subtitle: activityType.isArchived
            ? 'Are you sure you want to restore this activity?'
            : 'Are you sure you want to archive this activity?',
        deny: 'No',
        accept: 'Yes',
        onAccepted: () => ref
            .watch(activityTypeNotifierProvider.notifier)
            .toggleIsArchived(activityType),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final activityType in activeActivityTypes) ...[
              TmCard(
                actions: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () => handleArchiveActivity(activityType),
                  child: const Icon(
                    CupertinoIcons.archivebox,
                    size: 22,
                  ),
                ),
                child: Text(activityType.name),
              ),
              const SizedBox(height: 15),
            ],
            const SizedBox(height: 15),
            if (archivedActivityTypes.isNotEmpty) ...[
              const Text('Archived activities:'),
              const SizedBox(height: 20),
              for (final activityType in archivedActivityTypes) ...[
                TmCard(
                  actions: FilledButton(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(14),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () => handleArchiveActivity(activityType),
                    child: const Icon(
                      CupertinoIcons.restart,
                      size: 22,
                    ),
                  ),
                  child: Text(
                    activityType.name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 182, 182, 182),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
