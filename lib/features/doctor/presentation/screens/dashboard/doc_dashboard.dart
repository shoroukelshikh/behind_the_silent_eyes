import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/dashboard/doc_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/patients/patient_list.dart';
import '../profile/doc_profile.dart' show DocProfile;

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
    PatientList(),
    DocProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.surface,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.accent,
          unselectedItemColor: AppColors.textHint,
          elevation: 0,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/Dashboard.png')),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/dotors.png')),
              label: 'Patients',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/Diagnose.png')),
              label: 'Diagnose',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/adprofile.png')),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}