import 'package:flutter/material.dart';

Future<void> tmDialogConfirm({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String deny,
  required String accept,
  required VoidCallback onAccepted,
}) async {
  final hasAccepted = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text(title),
      content: Text(subtitle),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            deny,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            accept,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ],
    ),
  );

  if (hasAccepted ?? false) onAccepted();
}
