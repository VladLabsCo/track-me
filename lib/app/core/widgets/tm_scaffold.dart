import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';

class TmScaffold extends StatelessWidget {
  const TmScaffold({
    required this.child,
    this.fullScreen = false,
    this.nested = false,
    this.removePaddingTop = false,
    this.title = '',
    super.key,
  });

  factory TmScaffold.fullScreen({required Widget child}) {
    return TmScaffold(fullScreen: true, child: child);
  }

  factory TmScaffold.nested({
    required String title,
    required Widget child,
    bool removePaddingTop = false,
  }) {
    return TmScaffold(
      title: title,
      nested: true,
      removePaddingTop: removePaddingTop,
      child: child,
    );
  }

  final Widget child;
  final bool fullScreen;
  final bool nested;
  final bool removePaddingTop;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (fullScreen) {
      return Scaffold(body: child);
    }

    final content = Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!nested) ...[
            const SizedBox(height: 12),
            const TmLogo(),
            const SizedBox(height: 7),
          ],
          SizedBox(height: removePaddingTop ? 0 : 30),
          Expanded(child: child),
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: nested
            ? Column(
                children: [
                  const SizedBox(height: 4),
                  NestedHeader(title: title),
                  Expanded(child: content),
                ],
              )
            : content,
      ),
    );
  }
}

class NestedHeader extends StatelessWidget {
  const NestedHeader({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.zero,
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: context.pop,
          icon: const Icon(
            Icons.chevron_left_outlined,
            size: 30,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
