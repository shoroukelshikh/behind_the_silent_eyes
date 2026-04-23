import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/admin/presentation/screens/doctors/doc_list.dart';
import 'package:behind_silent_eyes/features/admin/presentation/screens/patient/patient_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../profile/admin_profile.dart';
import 'admindashboard_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    AdmindashboardPage(),
    PatientList(),
    DocList(),
    AdminProfile(),
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
            icon: ImageIcon(AssetImage('assets/images/dotors.png')),
            label: 'Doctors',
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