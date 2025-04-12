import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DurationInput extends StatelessWidget {
  const DurationInput({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final Duration value;
  final void Function(Duration) onChanged;

  Future<void> _showDurationPicker(BuildContext context) async {
    final selectedDuration = await showCupertinoModalPopup<Duration>(
      context: context,
      builder: (context) => _PickerPopup(initialValue: value),
    );

    if (selectedDuration != null) onChanged(selectedDuration);
  }

  String _formatDuration(Duration duration) {
    return timeFormat(duration);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
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
        onPressed: () => _showDurationPicker(context),
        child: Text(
          _formatDuration(value),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}

class _PickerPopup extends StatefulWidget {
  const _PickerPopup({required this.initialValue});

  final Duration initialValue;

  @override
  State<_PickerPopup> createState() => __PickerPopupState();
}

class __PickerPopupState extends State<_PickerPopup> {
  late Duration value;

  @override
  void initState() {
    value = widget.initialValue;

    super.initState();
  }

  void _handleValueChanged(Duration newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hm,
              initialTimerDuration: widget.initialValue,
              onTimerDurationChanged: _handleValueChanged,
            ),
          ),
          CupertinoButton(
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              Navigator.of(context).pop(value);
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

String timeFormat(Duration duration) {
  var timeString = '';

  final hours = duration.inHours.toString();
  final minutes = (duration.inMinutes % 60).toString();

  if (hours == '0' && minutes == '0') {
    timeString = '0m';
  } else {
    if (hours != '0') timeString = '${hours}h';
    if (minutes != '0') {
      timeString = '$timeString${timeString.isEmpty ? '' : ' '}${minutes}m';
    }
  }

  return timeString;
}
