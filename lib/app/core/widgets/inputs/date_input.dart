import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatelessWidget {
  const DateInput({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final DateTime value;
  final void Function(DateTime) onChanged;

  Future<void> _showDatePicker(BuildContext context) async {
    final selectedDate = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (context) => _PickerPopup(initialValue: value),
    );

    if (selectedDate != null) onChanged(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
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
        onPressed: () => _showDatePicker(context),
        child: Text(
          DateFormat('dd/MM/yyyy - HH:mm').format(value),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}

class _PickerPopup extends StatefulWidget {
  const _PickerPopup({required this.initialValue});

  final DateTime initialValue;

  @override
  State<_PickerPopup> createState() => __PickerPopupState();
}

class __PickerPopupState extends State<_PickerPopup> {
  late DateTime value;

  @override
  void initState() {
    value = widget.initialValue;

    super.initState();
  }

  void _handleValueChanged(DateTime newValue) {
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
            child: CupertinoDatePicker(
              maximumDate: DateTime.now(),
              use24hFormat: true,
              initialDateTime: widget.initialValue,
              onDateTimeChanged: _handleValueChanged,
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
