import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/gradient_card.dart';

class PatientDetails extends StatelessWidget {
  final Map<String, String> patient;
  const PatientDetails({super.key,required this.patient});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Back to patients',
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
              GradientCard(height: 320,width:335 ,children: [
                Padding(
                  padding: const EdgeInsets.all(11),
                  child: Row(
                    children: [
                      Icon(Icons.person,color: Colors.white,),
                      SizedBox(width: 9,),
                      Text(patient["name"] ?? "" , style: GoogleFonts.poppins(
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

                // national id
                Padding(
                  padding: const EdgeInsets.only(left:20 ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/code.png'),
                      SizedBox(width: 25,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('national id:' , style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0x66ffffff),
                          ),),
                          Text(patient["id"] ?? "", style: GoogleFonts.poppins(
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
                // date of birth
                Padding(
                  padding: const EdgeInsets.only(left:20 ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/date.png'),
                      SizedBox(width: 25,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('date of birth' , style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0x66ffffff),
                          ),),
                          Text(patient["dob"] ?? "" , style: GoogleFonts.poppins(
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
                // Gender
                Padding(
                  padding: const EdgeInsets.only(left:20 ),
                  child: Row(
                    children: [
                      Icon(Icons.transgender,color: Colors.white,size: 25,),
                      SizedBox(width: 25,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('gender' , style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0x66ffffff),
                          ),),
                          Text(patient["gender"] ?? "" , style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),)
                        ],
                      )
                    ],
                  ),
                ),
              ],),
            ),
          ],
        ),
      ),
    );
  }
}
