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

  Future<void> _confirmDelete(BuildContext context, DoctorEntity doctor) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Doctor'),
        content: Text('Are you sure you want to delete ${doctor.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
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
          // Re-apply search if there was a query
          if (_searchController.text.isNotEmpty) {
            _search(_searchController.text);
          }
        } else if (state is DoctorActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          // Reload list after any CRUD action
          context.read<AdminCubit>().loadDoctors();
        } else if (state is AdminFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AdminLoading;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // ── Search + Add Button ──────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: SearchField(
                        onSearch: _search,
                        hint: 'Search by name, code or email',
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff474161),
                        minimumSize: const Size(120, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AddDoc()),
                        );
                        // Always reload after returning from Add
                        if (mounted) {
                          context.read<AdminCubit>().loadDoctors();
                        }
                      },
                      child: Text(
                        'Add Doctor',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ── Loading / Empty / List ───────────────────────
                if (isLoading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF474161),
                      ),
                    ),
                  )
                else if (_filteredDoctors.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.person_search,
                            size: 64,
                            color: Color(0xFF474161),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _allDoctors.isEmpty
                                ? 'No doctors yet.\nTap "Add Doctor" to create one.'
                                : 'No doctors match your search.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF474161),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async =>
                          context.read<AdminCubit>().loadDoctors(),
                      child: ListView.builder(
                        itemCount: _filteredDoctors.length,
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
                              if (mounted) {
                                context.read<AdminCubit>().loadDoctors();
                              }
                            },
                            onView: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DocDetails(doctor: doctor),
                                ),
                              );
                            },
                            onDelete: () => _confirmDelete(context, doctor),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Doctor Card Widget ─────────────────────────────────────────
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Row 1: Avatar + Name + Edit ───────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0xff68848C),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blueGrey),
                  onPressed: onEdit,
                ),
              ],
            ),
            const SizedBox(height: 6),

            // ── Doctor Code ───────────────────────────────────
            _InfoRow(label: 'Doctor Code', value: doctor.doctorCode ?? '—'),
            const SizedBox(height: 4),
            _InfoRow(label: 'Email', value: doctor.email),
            const SizedBox(height: 4),
            _InfoRow(label: 'Phone', value: doctor.phone ?? '—'),

            const Divider(height: 20),

            // ── Actions Row ───────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onView,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0B2F60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}