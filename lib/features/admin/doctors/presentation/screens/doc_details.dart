import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/admin/doctors/presentation/widgets/gradient_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocDetails extends StatelessWidget {
  final Map<String, String> doctor;
  const DocDetails({super.key, required this.doctor});

  @override

  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Back to doctors',
              style: GoogleFonts.poppins(
                color: Color(0xff665F5F),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:
              GradientCard(height: 480,width:335 ,children: [
                Padding(
                  padding: const EdgeInsets.all(11),
                  child: Row(
                    children: [
                      Icon(Icons.person,color: Colors.white,),
                      SizedBox(width: 9,),
                      Text(doctor["name"] ?? "" , style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff),
                      ),)
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: Color(0x66ffffff),
                ),
                // email
                Padding(
                  padding: const EdgeInsets.only(left:20 ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/email.png'),
                      SizedBox(width: 25,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email:' , style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0x66ffffff),
                          ),),
                          Text(doctor["email"] ?? "" , style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                // code
                Padding(
                  padding: const EdgeInsets.only(left:20 ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/code.png'),
                      SizedBox(width: 25,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('code:' , style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0x66ffffff),
                          ),),
                          Text(doctor["code"] ?? "", style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                // phone
                Padding(
                  padding: const EdgeInsets.only(left:20 ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/phone.png'),
                      SizedBox(width: 25,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('phone' , style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0x66ffffff),
                          ),),
                          Text(doctor["phone"] ?? "" , style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                // date
                Padding(
                  padding: const EdgeInsets.only(left:20 ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/date.png'),
                      SizedBox(width: 25,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('registered on' , style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0x66ffffff),
                          ),),
                          Text(doctor["registered_on"] ?? "" , style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25,),

              ],),
            ),
          ],
        ),
      ),
    );
  }
}
