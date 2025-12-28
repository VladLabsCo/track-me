import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/activity_stats/widgets/activity_stats_tile.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

class ActivityStatsList extends ConsumerWidget {
  const ActivityStatsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final types = ref.watch(
      activityTypeProvider.select((s) => s.types),
    );
    final stats = ref.watch(
      activityStatsProvider.select((s) => s.stats),
    );

    final typesStatsRecords = <(ActivityType, ActivityStats)>[];

    for (final stat in stats) {
      final type = types.firstWhere((t) => t.id == stat.activityTypeId);
      if (type.isArchived) continue;

      typesStatsRecords.add((type, stat));
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (final (type, stat) in typesStatsRecords) ...[
              ActivityStatsTile(
                type: type,
                stats: stat,
              ),
              const SizedBox(height: 15),
            ],
          ],
        ),
      ),
    );
  }
}
