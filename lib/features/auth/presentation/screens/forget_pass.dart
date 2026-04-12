import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/admin/doctors/presentation/widgets/text_field.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/send_code.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPass extends StatefulWidget {

  ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff665F5F)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Forget password",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Color(0xff665F5F),
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: Column(
          children: [
            SizedBox(height: 180),
            Text(
              "Please enter your email to reset the password",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff665F5F),
              ),
            ),
            SizedBox(height: 70,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Email',
                    hintText: 'Enter your email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Email required';
                      if (!value.contains('@')) return 'Enter valid email';
                      return null;
                    },
                  ),
                  SizedBox(height: 50),

                  SizedBox(
                    width: 340,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Reset code sent"),
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SendCode(
                                email: emailController.text,
                              ),
                            ),
                          );

                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff474161),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Send reset code",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
