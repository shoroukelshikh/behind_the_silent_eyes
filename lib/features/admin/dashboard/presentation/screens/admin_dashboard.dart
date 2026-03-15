import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/admin/dashboard/presentation/screens/admindashboard_page.dart';
import 'package:behind_silent_eyes/features/admin/doctors/presentation/screens/doc_list.dart';
import 'package:behind_silent_eyes/features/admin/patient/presentation/screens/patient_list.dart';
import 'package:behind_silent_eyes/features/admin/profile/presentation/screens/admin_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    body: _pages[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Color(0xFF474161),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blueGrey,
      unselectedItemColor: Colors.white70,
      selectedLabelStyle:GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.bold,

      ),
      unselectedLabelStyle:
         GoogleFonts.poppins(
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
      body: Container(
        decoration:  BoxDecoration(
          gradient: AppColors.primary
        ),
        child: SafeArea(
          child: _pages[_currentIndex],
        ),
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