import 'package:flutter/material.dart';

class TmIconButton extends StatelessWidget {
  const TmIconButton({
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.backgroundColor,
    this.shadowColor,
    this.padding,
    super.key,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    final buttonWidget = FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: Size.zero,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        padding: EdgeInsets.all(padding ?? 20),
      ),
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: child,
    );

    if (shadowColor != null) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: shadowColor!.withAlpha(127),
              offset: const Offset(0, 3),
              blurRadius: 12,
            ),
          ],
        ),
        child: buttonWidget,
      );
    }

    return buttonWidget;
  }
}
