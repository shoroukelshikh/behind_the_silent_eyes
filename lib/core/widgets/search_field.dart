import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function(String) onSearch;
  final String hint;

  const SearchField({super.key,required this.onSearch,required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearch,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),

        hintText: hint,
        hintStyle: TextStyle(
          color: Color(0x66665F5F),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
