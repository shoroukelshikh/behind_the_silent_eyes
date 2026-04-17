import 'package:behind_silent_eyes/features/doctor/dashboard/presentation/screens/doc_dashboard_page.dart';
import 'package:behind_silent_eyes/features/doctor/diagnose/presentation/screens/diagnose.dart';
import 'package:behind_silent_eyes/features/doctor/patients/presentation/screens/patient_list.dart';
import 'package:behind_silent_eyes/features/doctor/profile/presentation/screens/doc_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/colors.dart';

class DocDashboard extends StatefulWidget {
  const DocDashboard({super.key});

  @override
  State<DocDashboard> createState() => _DocDashboardState();
}

class _DocDashboardState extends State<DocDashboard> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    DocDashboardPage(),
    PatientList(),
    Diagnose(),
    DocProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: double.infinity,
        decoration:  BoxDecoration(
            gradient: AppColors.primary
        ),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF474161),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/Dashboard.png')),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/dotors.png')),
            label: 'patients',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/Diagnose.png')),
            label: 'Diagnose',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/adprofile.png')),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
