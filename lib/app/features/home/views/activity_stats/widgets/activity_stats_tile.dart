import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

class ActivityStatsTile extends StatelessWidget {
  const ActivityStatsTile({
    required this.type,
    required this.stats,
    super.key,
  });

  final ActivityType type;
  final ActivityStats stats;

  @override
  Widget build(BuildContext context) {
    final nameStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontWeight: FontWeight.w500);

    final timeStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        );

    return Column(
      children: [
        TmCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type.name, style: nameStyle),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.time,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 8),
                  Text(tmTimeFormat(stats.totalDuration), style: timeStyle),
                  if (stats.lastUpdate != null) ...[
                    const SizedBox(width: 16),
                    const Icon(
                      CupertinoIcons.calendar,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 8),
                    Text(tmDateFormat(stats.lastUpdate!), style: timeStyle),
                  ],
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
