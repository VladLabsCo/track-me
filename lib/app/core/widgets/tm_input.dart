import 'package:flutter/material.dart';

class TmInput extends StatelessWidget {
  const TmInput({
    required this.label,
    required this.icon,
    required this.onChanged,
    this.keyboardType,
    super.key,
  });

  final String label;
  final Icon icon;
  final void Function(String) onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Container(
          width: 22,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 5),
          child: icon,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 50),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
        filled: true,
        fillColor: const Color(0xFFF0EFEF),
      ),
    );
  }
}
