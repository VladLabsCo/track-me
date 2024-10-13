import 'package:flutter/material.dart';

class TmButton extends StatelessWidget {
  const TmButton({
    required this.label,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    this.outlined = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final borderRadius = outlined ? 30.0 : 9.0;

    final backgroundColor =
        outlined ? Colors.transparent : Theme.of(context).primaryColor;

    final side = outlined
        ? BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          )
        : null;

    return TextButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: side,
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: padding,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
