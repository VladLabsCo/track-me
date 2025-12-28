import 'package:flutter/material.dart';

class DashboardNavbar extends StatelessWidget {
  const DashboardNavbar({
    required this.items,
    super.key,
  });

  final List<IconData> items;

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) => BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SizedBox.expand(
          child: Row(
            children: [
              for (final (index, item) in items.indexed) ...[
                _DashboardNavbarItem(
                  iconData: item,
                  isActive: index == tabController.index,
                  onPressed: () => tabController.animateTo(index),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardNavbarItem extends StatelessWidget {
  const _DashboardNavbarItem({
    required this.iconData,
    required this.isActive,
    required this.onPressed,
  });

  final IconData iconData;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox.expand(
        child: FilledButton(
          style: FilledButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.zero,
            overlayColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Icon(
            iconData,
            size: 34,
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.white.withAlpha(204),
          ),
        ),
      ),
    );
  }
}
