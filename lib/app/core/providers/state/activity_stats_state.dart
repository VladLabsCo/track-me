import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity_stats_state.freezed.dart';

@freezed
abstract class ActivityStatsState with _$ActivityStatsState {
  const factory ActivityStatsState({
    required List<ActivityStats> stats,
  }) = _ActivityStatsState;

  factory ActivityStatsState.inital(List<ActivityStats> stats) {
    return ActivityStatsState(stats: stats);
  }
}
