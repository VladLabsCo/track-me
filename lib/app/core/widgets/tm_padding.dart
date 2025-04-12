import 'package:flutter/material.dart';

class TmPadding extends StatelessWidget {
  const TmPadding({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}
