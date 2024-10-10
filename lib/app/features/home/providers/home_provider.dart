import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.freezed.dart';
part 'home_provider.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.timer() = TimerHome;
  const factory HomeState.stats() = StatsHome;
}

@Riverpod(keepAlive: true)
class HomeNotifier extends _$HomeNotifier {
  @override
  HomeState build() => const HomeState.timer();

  void goTimer() => state = const HomeState.timer();

  void goStats() => state = const HomeState.stats();
}
