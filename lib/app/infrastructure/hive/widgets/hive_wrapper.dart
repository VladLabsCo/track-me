import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveWrapper extends StatefulWidget {
  const HiveWrapper({required this.child, super.key});

  final Widget child;

  @override
  State<HiveWrapper> createState() => _HiveWrapperState();
}

class _HiveWrapperState extends State<HiveWrapper> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      Hive.close();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
