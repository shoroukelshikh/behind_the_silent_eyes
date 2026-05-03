import 'dart:convert';
import 'package:behind_silent_eyes/core/network/api_endpoints.dart';
import 'package:behind_silent_eyes/core/network/dio_client.dart';
import 'package:behind_silent_eyes/core/storage/local_storage.dart';
import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/admin/presentation/widgets/gradient_card.dart';
import 'package:behind_silent_eyes/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:behind_silent_eyes/features/auth/presentation/cubit/auth_state.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/login_screen.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/profile/edit-prof.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DocProfile extends StatefulWidget {
  const DocProfile({super.key});

  @override
  State<DocProfile> createState() => _DocProfileState();
}

class _DocProfileState extends State<DocProfile> {
  String name       = '';
  String email      = '';
  String phone      = '';
  String doctorCode = '';
  String role       = '';
  bool   isLoading  = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userJson = await LocalStorage.getUser();
    if (userJson != null && userJson.isNotEmpty) {
      final map = jsonDecode(userJson) as Map<String, dynamic>;
      setState(() {
        name       = map['name']        ?? '';
        email      = map['email']       ?? '';
        phone      = map['phone']       ?? '';
        doctorCode = map['doctor_code'] ?? '';
        role       = map['role']        ?? 'doctor';
        isLoading  = false;
      });

      // لو الـ phone مش موجود في الـ cache، نجيبه من الـ API
      if (phone.isEmpty) {
        _fetchFromApi();
      }
    } else {
      _fetchFromApi();
    }
  }

  Future<void> _fetchFromApi() async {
    try {
      final response = await DioClient.instance.get(ApiEndpoints.me);
      final map = response.data as Map<String, dynamic>;

      // نحدث الـ LocalStorage بالبيانات الكاملة
      final currentJson = await LocalStorage.getUser();
      if (currentJson != null) {
        final current = jsonDecode(currentJson) as Map<String, dynamic>;
        current['phone'] = map['phone'];
        current['name']  = map['name'];
        current['email'] = map['email'];
        await LocalStorage.saveUser(jsonEncode(current));
      }

      setState(() {
        name       = map['name']        ?? '';
        email      = map['email']       ?? '';
        phone      = map['phone']       ?? '';
        doctorCode = map['doctor_code'] ?? '';
        role       = map['role']        ?? 'doctor';
        isLoading  = false;
      });
    } catch (_) {
      setState(() => isLoading = false);
    }
  }

  void _goToEdit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProf(
          fullName: name,
          email:    email,
          phone:    phone,
          password: '',
        ),
      ),
    );
    // بعد الرجوع نعيد تحميل البيانات المحدثة
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess || state is AuthFailure) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor:         Colors.transparent,
        extendBodyBehindAppBar:  true,
        appBar: AppBar(
          elevation:       0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon:      const Icon(Icons.edit, color: Colors.black54),
              onPressed: isLoading ? null : _goToEdit,
            ),
          ],
        ),
        body: Container(
          height:    double.infinity,
          width:     double.infinity,
          decoration: BoxDecoration(gradient: AppColors.primary),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              GradientCard(
                width:        w * 0.85,
                height:       h * 0.58,
                borderRadius: BorderRadius.circular(15),
                children: [
                  _row('Doctor code', doctorCode.isEmpty ? '—' : doctorCode),
                  const Divider(thickness: 1.5, color: Color(0x66ffffff)),
                  _row('Full name', name.isEmpty ? '—' : name),
                  const Divider(thickness: 1.5, color: Color(0x66ffffff)),
                  _row('Email', email.isEmpty ? '—' : email),
                  const Divider(thickness: 1.5, color: Color(0x66ffffff)),
                  _row('Phone', phone.isEmpty ? '—' : phone),
                  const Divider(thickness: 1.5, color: Color(0x66ffffff)),
                  _row('Password', '••••••••'),
                  const Divider(thickness: 1.5, color: Color(0x66ffffff)),
                  _row('Role', role.isEmpty ? 'Doctor' : role[0].toUpperCase() + role.substring(1)),
                ],
              ),
              SizedBox(height: h * 0.02),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final loading = state is AuthLoading;
                  return CustomButton(
                    text:      loading ? 'Logging out...' : 'Logout',
                    size:      16,
                    weight:    FontWeight.w500,
                    width:     w * 0.85,
                    height:    h * 0.05,
                    onPressed: loading
                        ? () {}
                        : () => context.read<AuthCubit>().logout(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03,
        vertical:   8,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label + ':',
                  style: GoogleFonts.poppins(fontSize: 16, color: const Color(0x99ffffff))),
              Text(value,
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}