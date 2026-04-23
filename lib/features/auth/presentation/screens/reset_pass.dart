import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../admin/presentation/widgets/text_field.dart';
import 'success_newpass.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      extendBodyBehindAppBar: true
      ,appBar: AppBar(
      backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back) ,color:Color(0xff665f5f) ,),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        decoration: BoxDecoration(
          gradient: AppColors.primary,
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.117),
                Text("Set a new password",style: GoogleFonts.poppins(
                    fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff665F5F)
                ),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.074),
                CustomTextField(label: "password", hintText: "Enter your new password",
                  controller: passwordController,
                  obscureText: isPasswordHidden,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                    {return 'Password required';}
                    if (value.length < 6) return 'Min 6 chars';
                    return null;
                  },),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                CustomTextField(label: "confirm password",
                  hintText: "re-Enter your new password",
                  controller: repasswordController,
                  obscureText: isConfirmPasswordHidden,
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      isConfirmPasswordHidden = !isConfirmPasswordHidden;
                    });
                  }, icon: Icon(
                    isConfirmPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  ),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm password required';
                    }

                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                CustomButton(
                  height: MediaQuery.of(context).size.height * 0.074,
                  width: MediaQuery.of(context).size.width * 0.85,
                  text: "update password",
                  size: MediaQuery.of(context).size.width * 0.039, // ~16px
                  weight: FontWeight.bold,
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>SuccessNewPass() ,
                        ),
                      );
                    }
                    },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
