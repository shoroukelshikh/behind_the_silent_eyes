import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:behind_silent_eyes/core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final Color color;
  final double size;
  final FontWeight weight;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.size,
    required this.weight,
    required this.width,
    required this.height,
    this.color = AppColors.navy,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: size,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}