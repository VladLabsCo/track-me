import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';

class TmScaffold extends StatelessWidget {
  const TmScaffold({
    required this.body,
    this.fullScreen = false,
    this.nested = false,
    this.title = '',
    this.subtitle = '',
    this.bottomNavigationBar,
    this.floatingActionButton,
    super.key,
  });

  factory TmScaffold.fullScreen({required Widget body}) {
    return TmScaffold(fullScreen: true, body: body);
  }

  factory TmScaffold.nested({
    required String title,
    required Widget body,
    String subtitle = '',
  }) {
    return TmScaffold(
      nested: true,
      title: title,
      body: body,
      subtitle: subtitle,
    );
  }

  final Widget body;
  final bool fullScreen;
  final bool nested;
  final String title;
  final String subtitle;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    if (fullScreen) {
      return Scaffold(body: body);
    }

    final descriptionStyle = Theme.of(context)
        .textTheme
        .bodySmall!
        .copyWith(color: Colors.white.withAlpha(180));

    final heading = TmPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (subtitle.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: Text(subtitle, style: descriptionStyle),
            ),
          if (!nested) ...[
            const SizedBox(height: 12),
            const TmLogo(),
            const SizedBox(height: 7),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading,
        if (bottomNavigationBar == null)
          Expanded(child: TmPadding(child: body))
        else
          Expanded(child: body),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: nested
            ? Column(
                children: [
                  const SizedBox(height: 4),
                  NestedHeader(title: title),
                  const SizedBox(height: 4),
                  Expanded(child: content),
                ],
              )
            : content,
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
