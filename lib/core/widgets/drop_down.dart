import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:behind_silent_eyes/core/theme/colors.dart';

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
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            value: value,
            validator: validator,
            onChanged: onChanged,
            dropdownColor: AppColors.surface,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
            hint: Text(
              hintText,
              style: GoogleFonts.poppins(
                color: AppColors.textHint,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.border, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.accent, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.danger, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.danger, width: 1.5),
              ),
            ),
            items: items
                .map((item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ))
                .toList(),
          ),
        ),
      ],
    );
  }
}