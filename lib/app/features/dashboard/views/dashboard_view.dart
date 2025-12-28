import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/dashboard/widgets/dashboard_fab.dart';
import 'package:track_me/app/features/dashboard/widgets/dashboard_navbar.dart';
import 'package:track_me/app/features/features.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: TmScaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ActivityTimerView(),
            ActivityStatsView(),
            // ActivityTargetsView(),
          ],
        ),
        floatingActionButton: DashboardFab(),
        bottomNavigationBar: DashboardNavbar(
          items: [
            CupertinoIcons.timer,
            Icons.bar_chart_rounded,
            // CupertinoIcons.bolt_fill,
          ],
        ),
      ),
    );
  }
}
