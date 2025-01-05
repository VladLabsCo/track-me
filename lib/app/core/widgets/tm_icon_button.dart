import 'package:flutter/material.dart';

class TmIconButton extends StatelessWidget {
  const TmIconButton({
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.backgroundColor,
    this.shadowColor,
    this.padding,
    this.disabled,
    this.disabledOpacity,
    super.key,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? padding;
  final bool? disabled;
  final double? disabledOpacity;

  @override
  Widget build(BuildContext context) {
    Widget buttonWidget = FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: Size.zero,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        disabledBackgroundColor:
            backgroundColor ?? Theme.of(context).primaryColor,
        padding: EdgeInsets.all(padding ?? 20),
      ),
      onPressed: (disabled ?? false) ? null : onPressed,
      onLongPress: (disabled ?? false) ? null : onLongPress,
      child: child,
    );

    if (disabled != null) {
      buttonWidget = AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: disabled! ? (disabledOpacity ?? 0.5) : 1.0,
        child: buttonWidget,
      );

      if (disabled!) return buttonWidget;
    }

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
