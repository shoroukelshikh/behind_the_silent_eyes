import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/admin/dashboard/presentation/screens/admin_dashboard.dart';
import 'package:behind_silent_eyes/features/admin/doctors/presentation/widgets/text_field.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/forget_pass.dart';
import 'package:behind_silent_eyes/features/doctor/dashboard/presentation/screens/doc_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 100, height: 100),
              const SizedBox(height: 20),
              Container(
                width: 330,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xffDAE0E8FF).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white70),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff665F5F)
                      ),
                    ),
                    SizedBox(height: 20),
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
                          SizedBox(height: 10,),
                          CustomTextField(
                            label: 'password',
                            hintText: 'please enter password',
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
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPass(),
                            ),
                          );
                        },
                        child:  Text(
                          "Forgot password ?",
                          style: GoogleFonts.poppins(color:Color(0xff0400FF),fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff474161),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()){
                            if(emailController.text=="doctor@gmail.com"){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocDashboard(),));}

                          else{
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminDashboard(),));}

                        }}
                        ,
                        child:  Text(
                          "Login",
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
