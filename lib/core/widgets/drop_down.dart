import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? value;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: const Color(0xff665F5F),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            value: value,
            validator: validator,
            onChanged: onChanged,
            hint: Text(
              hintText,
              style: GoogleFonts.poppins(
                color: const Color(0x66665F5F),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.grey, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xcc474161), width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: const Color(0x66665F5F),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            items: items
                .map((item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ))
                .toList(),
          ),
        ),
      ],
    );
  }
}