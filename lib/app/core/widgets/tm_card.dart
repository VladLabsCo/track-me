import 'package:flutter/material.dart';

class TmCard extends StatelessWidget {
  const TmCard({
    required this.child,
    this.actions,
    super.key,
  });

  final Widget child;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ),
          if (actions != null) actions!,
        ],
      ),
    );
  }
}
