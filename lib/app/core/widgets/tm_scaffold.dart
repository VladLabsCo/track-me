import 'package:flutter/material.dart';

class TmScaffold extends StatelessWidget {
  const TmScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
    );
  }
}
