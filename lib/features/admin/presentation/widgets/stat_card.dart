import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:behind_silent_eyes/core/theme/colors.dart';

class StatCard extends StatelessWidget {
  final String text;
  final String num;
  final String icon;

  const StatCard({
    super.key,
    required this.text,
    required this.num,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  num,
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            icon,
            color: AppColors.navy,
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}