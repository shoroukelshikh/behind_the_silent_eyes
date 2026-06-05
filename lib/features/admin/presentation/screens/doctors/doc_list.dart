import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:behind_silent_eyes/features/admin/presentation/cubit/admin_state.dart';
import 'package:behind_silent_eyes/features/admin/presentation/screens/doctors/add_doc.dart';
import 'package:behind_silent_eyes/features/admin/presentation/screens/doctors/doc_details.dart';
import 'package:behind_silent_eyes/features/admin/presentation/screens/doctors/edit_doc.dart';
import 'package:behind_silent_eyes/features/admin/domain/entities/doctor_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/search_field.dart';

class DocList extends StatefulWidget {
  const DocList({super.key});

  @override
  State<DocList> createState() => _DocListState();
}

class _DocListState extends State<DocList> {
  List<DoctorEntity> _allDoctors = [];
  List<DoctorEntity> _filteredDoctors = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().loadDoctors();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredDoctors = List.from(_allDoctors);
      } else {
        final q = query.toLowerCase();
        _filteredDoctors = _allDoctors.where((d) {
          return d.name.toLowerCase().contains(q) ||
              (d.doctorCode?.toLowerCase().contains(q) ?? false) ||
              d.email.toLowerCase().contains(q);
        }).toList();
      }
    });
  }

  Future<void> _confirmDelete(
      BuildContext context, DoctorEntity doctor) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete doctor',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
        content: Text(
          'Are you sure you want to delete ${doctor.name}? This action cannot be undone.',
          style: GoogleFonts.poppins(
              fontSize: 14, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel',
                style: GoogleFonts.poppins(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete',
                style: GoogleFonts.poppins(
                    color: AppColors.danger, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      context.read<AdminCubit>().deleteDoctor(doctor.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is DoctorsLoaded) {
          setState(() {
            _allDoctors = state.doctors;
            _filteredDoctors = List.from(state.doctors);
          });
          if (_searchController.text.isNotEmpty) {
            _search(_searchController.text);
          }
        } else if (state is DoctorActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message,
                  style: GoogleFonts.poppins(fontSize: 13)),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
          context.read<AdminCubit>().loadDoctors();
        } else if (state is AdminFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message,
                  style: GoogleFonts.poppins(fontSize: 13)),
              backgroundColor: AppColors.danger,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AdminLoading;

        return Column(
          children: [
            // ── App Bar ────────────────────────────────────────────
            Container(
              height: 64,
              color: AppColors.navy,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset('assets/images/appbar.png', height: 28),
                ],
              ),
            ),

            // ── Search + Add ───────────────────────────────────────
            Container(
              color: AppColors.surface,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: SearchField(
                      onSearch: _search,
                      hint: 'Search by name, code or email',
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.navy,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                      ),
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: Text(
                        'Add',
                        style: GoogleFonts.poppins(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AddDoc()),
                        );
                        if (mounted) context.read<AdminCubit>().loadDoctors();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),

            // ── List / Loading / Empty ─────────────────────────────
            Expanded(
              child: isLoading
                  ? const Center(
                  child: CircularProgressIndicator(color: AppColors.accent))
                  : _filteredDoctors.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.accentLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.people_outline_rounded,
                          color: AppColors.accent, size: 34),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _allDoctors.isEmpty
                          ? 'No doctors yet'
                          : 'No results found',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _allDoctors.isEmpty
                          ? 'Tap "Add" to create the first doctor.'
                          : 'Try a different search term.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
                  : RefreshIndicator(
                color: AppColors.accent,
                onRefresh: () async =>
                    context.read<AdminCubit>().loadDoctors(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredDoctors.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final doctor = _filteredDoctors[index];
                    return _DoctorCard(
                      doctor: doctor,
                      onEdit: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditDoc(doctor: doctor),
                          ),
                        );
                        if (mounted)
                          context.read<AdminCubit>().loadDoctors();
                      },
                      onView: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DocDetails(doctor: doctor),
                        ),
                      ),
                      onDelete: () =>
                          _confirmDelete(context, doctor),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── Doctor Card ────────────────────────────────────────────────────
class _DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;
  final VoidCallback onEdit;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const _DoctorCard({
    required this.doctor,
    required this.onEdit,
    required this.onView,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Avatar ──────────────────────────────────────────
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_rounded,
                color: AppColors.accent, size: 24),
          ),
          const SizedBox(width: 14),

          // ── Info ────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                if (doctor.doctorCode != null)
                  _Tag(label: doctor.doctorCode!),
                const SizedBox(height: 6),
                _MetaRow(
                    icon: Icons.email_outlined, text: doctor.email),
                if (doctor.phone != null && doctor.phone!.isNotEmpty)
                  _MetaRow(
                      icon: Icons.phone_outlined, text: doctor.phone!),
              ],
            ),
          ),

          // ── Actions ─────────────────────────────────────────
          Column(
            children: [
              _IconBtn(
                  icon: Icons.remove_red_eye_outlined,
                  color: AppColors.accent,
                  onTap: onView),
              const SizedBox(height: 6),
              _IconBtn(
                  icon: Icons.edit_outlined,
                  color: AppColors.textSecondary,
                  onTap: onEdit),
              const SizedBox(height: 6),
              _IconBtn(
                  icon: Icons.delete_outline_rounded,
                  color: AppColors.danger,
                  onTap: onDelete),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.accent,
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _MetaRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(icon, size: 13, color: AppColors.textSecondary),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: AppColors.textSecondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _IconBtn(
      {required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 17),
      ),
    );
  }
}