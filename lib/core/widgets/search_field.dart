import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:behind_silent_eyes/core/theme/colors.dart';

class SearchField extends StatelessWidget {
  final Function(String) onSearch;
  final String hint;

  const SearchField({super.key, required this.onSearch, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearch,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.surface,
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.textSecondary,
          size: 20,
        ),
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: AppColors.textHint,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}