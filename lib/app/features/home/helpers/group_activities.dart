import 'package:track_me/app/infrastructure/infrastucture.dart';

bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

Map<String, List<Activity>> groupActivities(List<Activity> activities) {
  final now = DateTime.now();
  final todayDate = DateTime(now.year, now.month, now.day);
  final yesterdayDate = todayDate.subtract(const Duration(days: 1));
  final startOfWeekDate = todayDate.subtract(
    Duration(days: todayDate.weekday - 1),
  );
  final startOfMonthDate = DateTime(now.year, now.month);

  final today = <Activity>[];
  final yesterday = <Activity>[];
  final week = <Activity>[];
  final month = <Activity>[];
  final other = <Activity>[];

  final thirtyDaysAgo = now.subtract(const Duration(days: 30));
  final last30DaysActivities = activities.where(
    (activity) => activity.date.isAfter(thirtyDaysAgo),
  );

  for (final activity in last30DaysActivities) {
    final activityDate = activity.date;

    if (_isSameDay(activityDate, todayDate)) {
      today.add(activity);
    } else if (_isSameDay(activityDate, yesterdayDate)) {
      yesterday.add(activity);
    } else if (activityDate.isAfter(startOfWeekDate) &&
        (activityDate.isBefore(todayDate) ||
            _isSameDay(activityDate, startOfWeekDate))) {
      week.add(activity);
    } else if (activityDate.isAfter(startOfMonthDate) &&
        (activityDate.isBefore(startOfWeekDate) ||
            _isSameDay(activityDate, startOfMonthDate))) {
      month.add(activity);
    } else {
      other.add(activity);
    }
  }

  return {
    'Today': today,
    'Yesterday': yesterday,
    'This week': week,
    'This month': month,
    'Past months': other,
  };
}
