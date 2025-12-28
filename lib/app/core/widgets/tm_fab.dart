import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TmFab extends StatelessWidget {
  const TmFab({
    this.toolip,
    this.onPressed,
    super.key,
  });

  final String? toolip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return FloatingActionButton(
      elevation: 0,
      tooltip: toolip,
      shape: CircleBorder(
        side: BorderSide(width: 2, color: primaryColor),
      ),
      backgroundColor: Theme.of(context).cardColor,
      onPressed: onPressed,
      child: Icon(
        CupertinoIcons.add,
        size: 28,
        color: primaryColor,
      ),
    );
  }
}
