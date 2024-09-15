import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/features/home/providers/activity_provider.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

class ActivityPicker extends ConsumerWidget {
  const ActivityPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(activityNotifierProvider);
    final activities = activityState.activities;
    final activeId = activityState.activeId;

    final activeIndex = activeId != null
        ? activities.indexWhere((activity) => activity.id == activeId)
        : null;

    Future<void> showDialog() async {
      final selectedActivityId = await showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => _ActivityPickerPopup(
          activities: activities,
          initialIndex: activeIndex,
        ),
      );

      if (selectedActivityId != null) {
        if (selectedActivityId == '0') {
          if (context.mounted) context.go('/activity-form');
        } else {
          ref
              .read(activityNotifierProvider.notifier)
              .setActive(selectedActivityId);
        }
      }
    }

    return Center(
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(width: 0.5, color: Colors.white.withOpacity(0.5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: showDialog,
        child: Text(
          activeIndex != null
              ? activities[activeIndex].name
              : 'Select activity',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}

class _ActivityPickerPopup extends StatefulWidget {
  const _ActivityPickerPopup({required this.activities, this.initialIndex});

  final List<Activity> activities;
  final int? initialIndex;

  @override
  State<_ActivityPickerPopup> createState() => _ActivityPickerPopupState();
}

class _ActivityPickerPopupState extends State<_ActivityPickerPopup> {
  late final initalIndex = widget.initialIndex ?? 0;

  late int _selectedItemIndex = initalIndex;
  late final FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: initalIndex);

  @override
  Widget build(BuildContext context) {
    final activitiesLength = widget.activities.length;

    void handleDone() {
      if (_selectedItemIndex + 1 > activitiesLength) {
        Navigator.of(context).pop('0');
      } else {
        Navigator.of(context).pop(widget.activities[_selectedItemIndex].id);
      }
    }

    return Container(
      height: 236,
      padding: const EdgeInsets.only(top: 6),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: Theme.of(context).cardColor,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: 32,
                scrollController: _scrollController,
                onSelectedItemChanged: (itemIndex) => setState(() {
                  _selectedItemIndex = itemIndex;
                }),
                children: List<Widget>.generate(
                  activitiesLength + 1,
                  (int index) {
                    final text = (index + 1) > activitiesLength
                        ? 'New...'
                        : widget.activities[index].name;

                    return Center(
                      child: Text(
                        text,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
            CupertinoButton(
              onPressed: handleDone,
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
