import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TmFab extends StatelessWidget {
  const TmFab({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return FloatingActionButton(
      elevation: 0,
      tooltip: 'Add activity manually',
      shape: CircleBorder(
        side: BorderSide(width: 2, color: primaryColor),
      ),
      backgroundColor: Theme.of(context).cardColor,
      onPressed: () {},
      child: Icon(
        CupertinoIcons.add,
        size: 28,
        color: primaryColor,
      ),
    );
  }
}
