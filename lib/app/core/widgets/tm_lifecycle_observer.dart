import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';

class TmLifecycleObserver extends ConsumerStatefulWidget {
  const TmLifecycleObserver({required this.children, super.key});

  final Widget children;

  @override
  ConsumerState<TmLifecycleObserver> createState() =>
      _TmLifecycleObserverState();
}

class _TmLifecycleObserverState extends ConsumerState<TmLifecycleObserver> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onResume: () {
        ref.read(timerNotifierProvider.notifier).maybeResumeFromDisk();
        ref.read(activityTypeNotifierProvider.notifier).maybeResumeFromDisk();
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.children;
  }
}
