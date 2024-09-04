import 'package:flutter/material.dart';

class TmScaffold extends StatelessWidget {
  const TmScaffold({required this.child, this.fullScreen, super.key});

  factory TmScaffold.fullScreen({required Widget child}) {
    return TmScaffold(fullScreen: true, child: child);
  }

  final Widget child;
  final bool? fullScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (fullScreen ?? false)
          ? child
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: child,
              ),
            ),
    );
  }
}
