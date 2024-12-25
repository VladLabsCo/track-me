import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/home/views/activity_stats/widgets/activity_stats_tile.dart';

class ActivityStatsList extends ConsumerWidget {
  const ActivityStatsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final types = ref.watch(
      activityTypeNotifierProvider.select((s) => s.types),
    );
    final stats = ref.watch(
      activityStatsNotifierProvider.select((s) => s.stats),
    );

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...types.map(
              (type) => ActivityStatsTile(
                type: type,
                stats: stats.firstWhere(
                  (stats) => stats.activityTypeId == type.id,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
