import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatCard extends StatelessWidget {
  final String text;
  final String num;
  final String icon;
  const StatCard({super.key,
    required this.text,
    required this.num,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172,
      height: 88 ,
      decoration: BoxDecoration(
        color:Color(0x90FFFFFF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withAlpha(20),
            offset: Offset(0,4 ),
            spreadRadius: 5,
            blurRadius: 5
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(text,style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xff665F5F)
              ),),
              Text(num,style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000)
              ),),
            ],
          ),
          Image.asset(icon,color: Color(0xff000000),width: 28,height: 35,),
        ],
      ),
    ) ;
  }
}





