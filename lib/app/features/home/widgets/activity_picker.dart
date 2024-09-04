import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';

class ActivityPicker extends StatefulWidget {
  const ActivityPicker({super.key});

  @override
  State<ActivityPicker> createState() => _ActivityPickerState();
}

class _ActivityPickerState extends State<ActivityPicker> {
  int _selectedItemIndex = -1;
  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showDialog() async {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 236,
          padding: const EdgeInsets.only(top: 6),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
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
                    scrollController: FixedExtentScrollController(),
                    onSelectedItemChanged: (int itemIndex) {
                      setState(() {
                        _selectedItemIndex = itemIndex;
                      });
                    },
                    children: List<Widget>.generate(3, (int index) {
                      return Center(child: Text(index.toString()));
                    }),
                  ),
                ),
                CupertinoButton(
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    print(_selectedItemIndex);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    return TmButton(label: 'Miao', onPressed: showDialog);
  }
}
