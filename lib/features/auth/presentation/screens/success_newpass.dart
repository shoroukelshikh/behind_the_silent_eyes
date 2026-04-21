import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessNewPass extends StatelessWidget {
  const SuccessNewPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.246),
            Image(image: AssetImage("assets/images/success.png")),
            SizedBox(height: MediaQuery.of(context).size.height * 0.074),
            Text(
              "your password has been reset successfully",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff665F5F),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.148),
            CustomButton(
              text: "Login again",
              onPressed: () {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen(),)
                );
              },
              size: MediaQuery.of(context).size.width * 0.039,
              weight: FontWeight.bold,
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.074,
            ),
          ],
        ),
      ),
    );
  }
}
