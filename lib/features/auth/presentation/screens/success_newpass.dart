import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessNewPass extends StatelessWidget {
  const SuccessNewPass({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200,),
            Image(image: AssetImage("assets/images/success.png")),
            SizedBox(height: 60,),
            Text(
              "your password has been reset successfully",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff665F5F)
              ),
            ),
          ],
        )
      ),
    );
  }
}
