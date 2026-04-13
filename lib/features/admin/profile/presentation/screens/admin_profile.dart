import 'package:behind_silent_eyes/features/admin/doctors/presentation/widgets/gradient_card.dart';
import 'package:behind_silent_eyes/features/admin/profile/presentation/screens/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            color: Color(0xff665F5F),
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(
                    fullName: "Salma elsheikh",
                    email: "Salma@gmail.com",
                    phone: "0101534879",
                    password: "admin123",
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GradientCard(
                height: 350,
                width: 335,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 45, top: 30),
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
                              'Salma elsheikh',
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
                    padding: const EdgeInsets.only(left: 45),
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
                              'Salma@gmail.com',
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
                    padding: const EdgeInsets.only(left: 45),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone:',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Color(0x66ffffff),
                              ),
                            ),
                            Text(
                              '0101534879',
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
                    padding: const EdgeInsets.only(left: 45),
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
                              'Admin',
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
                    padding: const EdgeInsets.only(left: 45),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password:',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Color(0x66ffffff),
                              ),
                            ),
                            Text(
                              'Admin123',
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
              SizedBox(height: 15),
              SizedBox(
                width: 335,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xcc474161),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => LoginPage(),
                    //   ),
                    // );
                  },
                  child: Text(
                    "Logout",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
