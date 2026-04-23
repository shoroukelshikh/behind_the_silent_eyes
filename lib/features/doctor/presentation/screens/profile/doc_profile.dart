import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/admin/presentation/widgets/gradient_card.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/login_screen.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/profile/edit-prof.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocProfile extends StatelessWidget {
  const DocProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black54),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProf(
                    fullName: "shorouk elsheikh",
                    email: "shorouk@gmail.com",
                    phone: "01222339770",
                    password: "doc123",
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientCard(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.58,
              borderRadius: BorderRadius.circular(15),
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Doctor code:',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Color(0x66ffffff),
                            ),
                          ),
                          Text(
                            'doc_123',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1.5, color: Color(0x66ffffff)),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Full name:',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Color(0x66ffffff),
                            ),
                          ),
                          Text(
                            'shorouk elseikh',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1.5, color: Color(0x66ffffff)),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Email:',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Color(0x66ffffff),
                            ),
                          ),
                          Text(
                            'shoroukelsheikh@g.com',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1.5, color: Color(0x66ffffff)),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'password:',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Color(0x66ffffff),
                            ),
                          ),
                          Text(
                            'doctor_123',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1.5, color: Color(0x66ffffff)),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'phone:',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Color(0x66ffffff),
                            ),
                          ),
                          Text(
                            '01222339770',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1.5, color: Color(0x66ffffff)),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Role:',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Color(0x66ffffff),
                            ),
                          ),
                          Text(
                            'Doctor',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height:  MediaQuery.of(context).size.height*.02,),
            CustomButton(
              text: "Logout",
              size: 16,
              weight: FontWeight.w500,
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.05,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },

            ),
          ],
        ),
      ),
    );
  }
}
