import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/admin/dashboard/presentation/screens/admin_dashboard.dart';
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
            SizedBox(height: 200),
            Image(image: AssetImage("assets/images/success.png")),
            SizedBox(height: 60),
            Text(
              "your password has been reset successfully",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff665F5F),
              ),
            ),
            SizedBox(height: 120),
            CustomButton(
              text: "go to home page",
              onPressed: () {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AdminDashboard(),)
                );
              },
              size: 16,
              weight: FontWeight.bold,
              width: 350,
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
