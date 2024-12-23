import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';

class TmScaffold extends StatelessWidget {
  const TmScaffold({
    required this.body,
    this.fullScreen = false,
    this.nested = false,
    this.removePaddingTop = false,
    this.title = '',
    this.bottomNavigationBar,
    super.key,
  });

  factory TmScaffold.fullScreen({required Widget body}) {
    return TmScaffold(fullScreen: true, body: body);
  }

  factory TmScaffold.nested({
    required String title,
    required Widget body,
    bool removePaddingTop = false,
  }) {
    return TmScaffold(
      title: title,
      nested: true,
      removePaddingTop: removePaddingTop,
      body: body,
    );
  }

  final Widget body;
  final bool fullScreen;
  final bool nested;
  final bool removePaddingTop;
  final String title;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    if (fullScreen) {
      return Scaffold(body: body);
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
          SizedBox(height: removePaddingTop ? 0 : 20),
          Expanded(child: body),
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
      bottomNavigationBar: bottomNavigationBar,
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
