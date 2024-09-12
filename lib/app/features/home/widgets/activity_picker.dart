import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/features/home/providers/activity_provider.dart';

const activities = ['Work', 'Course', 'Gym'];

class ActivityPicker extends ConsumerWidget {
  const ActivityPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(activityNotifierProvider).activeIndex;

    Future<void> showDialog() async {
      final selectedItemIndex = await showCupertinoModalPopup<int>(
        context: context,
        builder: (BuildContext context) => _ActivityPickerPopup(
          initialIndex: activeIndex,
        ),
      );

      if (selectedItemIndex != null) {
        ref
            .read(activityNotifierProvider.notifier)
            .setActive(selectedItemIndex);
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
          activeIndex != null ? activities[activeIndex] : 'Select activity',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}

class _ActivityPickerPopup extends StatefulWidget {
  const _ActivityPickerPopup({this.initialIndex});

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
                children: List<Widget>.generate(3, (int index) {
                  return Center(
                    child: Text(
                      activities[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
              ),
            ),
            CupertinoButton(
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop(_selectedItemIndex);
              },
            ),
          ],
        ),
      ),
    );
  }
}
