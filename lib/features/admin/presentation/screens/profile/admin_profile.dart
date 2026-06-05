import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/data/models/user_model.dart';
import 'package:behind_silent_eyes/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:behind_silent_eyes/features/auth/presentation/cubit/auth_state.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/storage/local_storage.dart';
import 'edit_profile.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final userJson = await LocalStorage.getUser();
    if (userJson != null && mounted) {
      setState(() => _currentUser = UserModel.fromJsonString(userJson));
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Sign out',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: GoogleFonts.poppins(
              fontSize: 14, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.poppins(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().logout();
            },
            child: Text('Sign out',
                style: GoogleFonts.poppins(
                    color: AppColors.danger, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess || state is AuthFailure) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
          );
        }
      },
      child: Column(
        children: [
          // ── App Bar ─────────────────────────────────────────────
          Container(
            height: 64,
            color: AppColors.navy,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/appbar.png', height: 28),
                // IconButton(
                //   icon: const Icon(Icons.edit_outlined,
                //       color: Colors.white, size: 20),
                //   tooltip: 'Edit profile',
                //   onPressed: _currentUser == null
                //       ? null
                //       : () async {
                //     await Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (_) => EditAdminProfile(
                //             currentUser: _currentUser!),
                //       ),
                //     );
                //     _loadUser();
                //   },
                // ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // ── Profile header ───────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: const BoxDecoration(
                            color: AppColors.navy,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person_rounded,
                              color: Colors.white, size: 38),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          _currentUser?.name ?? '—',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accentLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'ADMIN',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accent,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Info card ────────────────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.accentLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.info_outline_rounded,
                                    color: AppColors.accent, size: 17),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Account information',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1, color: AppColors.border),
                        _InfoTile(
                            icon: Icons.person_outline_rounded,
                            label: 'Full name',
                            value: _currentUser?.name ?? '—'),
                        const Divider(
                            height: 1,
                            color: AppColors.border,
                            indent: 16,
                            endIndent: 16),
                        _InfoTile(
                            icon: Icons.email_outlined,
                            label: 'Email',
                            value: _currentUser?.email ?? '—'),
                        const Divider(
                            height: 1,
                            color: AppColors.border,
                            indent: 16,
                            endIndent: 16),
                        _InfoTile(
                            icon: Icons.phone_outlined,
                            label: 'Phone',
                            value: _currentUser?.phone ?? '—',
                            isLast: true),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Logout button ────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.danger,
                        side: BorderSide(
                            color: AppColors.danger.withOpacity(0.4)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.logout_rounded, size: 18),
                      label: Text(
                        'Sign out',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: _showLogoutDialog,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.textSecondary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}