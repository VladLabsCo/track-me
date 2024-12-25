import 'package:flutter/material.dart';

enum TmButtonSize {
  normal,
  small,
}

class TmButton extends StatelessWidget {
  const TmButton(
    this.label, {
    required this.onPressed,
    this.outlined = false,
    this.size = TmButtonSize.normal,
    this.padding,
    this.rightIcon,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  final TmButtonSize size;
  final EdgeInsetsGeometry? padding;
  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        outlined ? Colors.transparent : Theme.of(context).primaryColor;

    final side = outlined
        ? BorderSide(
            color: Theme.of(context).primaryColor,
          )
        : null;

    var sizePadding = padding ??
        const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        );
    if (size == TmButtonSize.small && padding == null) {
      sizePadding = const EdgeInsets.all(12);
    }

    var textStyle = Theme.of(context).textTheme.labelMedium;
    if (size == TmButtonSize.small) {
      textStyle = Theme.of(context).textTheme.labelSmall;
    }

    return TextButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: side,
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: sizePadding,
        minimumSize: Size.zero,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: textStyle,
          ),
          if (rightIcon != null) ...[
            const SizedBox(width: 4),
            rightIcon!,
          ],
        ],
      ),
    );
  }
}
