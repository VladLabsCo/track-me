import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

class ActivityPicker extends ConsumerWidget {
  const ActivityPicker({
    this.forForm = false,
    super.key,
  });

  final bool forForm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(
      timerNotifierProvider.select((s) => s.clockState),
    );
    final activityTypeState = ref.watch(activityTypeNotifierProvider);
    final activityTypes = activityTypeState.types;
    final activeType = activityTypeState.active;

    final activeIndex = activeType != null
        ? activityTypes
            .indexWhere((activityType) => activityType.id == activeType.id)
        : null;

    Future<void> showDialog() async {
      final result = await showCupertinoModalPopup<(bool, ActivityType?)?>(
        context: context,
        builder: (BuildContext context) => _ActivityPickerPopup(
          forForm: forForm,
          activityTypes: activityTypes,
          initialIndex: activeIndex,
        ),
      );

      if (result != null) {
        if (result.$1 && !forForm) {
          if (context.mounted) context.go('/new-type');
        } else {
          ref.read(activityTypeNotifierProvider.notifier).setActive(result.$2);
        }
      }
    }

    final button = OutlinedButton(
      style: ElevatedButton.styleFrom(
        side: const BorderSide(width: 0.5, color: Colors.white54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 0,
        backgroundColor: Colors.white12,
        disabledBackgroundColor: Colors.white10,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      onPressed: timerState == TimerClockState.initial ? showDialog : null,
      child: Text(
        activeIndex != null
            ? activityTypes[activeIndex].name
            : 'Select activity',
        style: forForm
            ? Theme.of(context).textTheme.labelSmall
            : Theme.of(context).textTheme.labelMedium,
      ),
    );

    if (forForm) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return Center(child: button);
  }
}

class _ActivityPickerPopup extends StatefulWidget {
  const _ActivityPickerPopup({
    required this.forForm,
    required this.activityTypes,
    this.initialIndex,
  });

  final bool forForm;
  final List<ActivityType> activityTypes;
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
    final activitiesLength = widget.activityTypes.length;

    void handleDone() {
      if (_selectedItemIndex + 1 > activitiesLength) {
        Navigator.of(context).pop((true, null));
      } else {
        Navigator.of(context).pop(
          (false, widget.activityTypes[_selectedItemIndex]),
        );
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
            if (activitiesLength == 0) ...[
              const SizedBox(height: 12),
              Text(
                widget.forForm
                    ? 'No activities yet'
                    : "No activities yet. Tap 'Done' to add one.",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            if (widget.forForm && activitiesLength == 0)
              const Expanded(
                child: SizedBox(width: double.infinity),
              )
            else
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
                    widget.forForm ? activitiesLength : activitiesLength + 1,
                    (int index) {
                      final text = (index + 1) > activitiesLength
                          ? 'New...'
                          : widget.activityTypes[index].name;

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
