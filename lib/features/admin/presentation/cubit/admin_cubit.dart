import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/create_doctor_usecase.dart';
import '../../domain/usecases/delete_docotor_usecase.dart';
import '../../domain/usecases/get_admin_stats_usecase.dart';
import '../../domain/usecases/get_doctor_byId_usecase.dart';
import '../../domain/usecases/get_doctors_usecase.dart';
import '../../domain/usecases/update_admin_profile_usecase.dart';
import '../../domain/usecases/update_doctor_usecase.dart';
import 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final GetDoctorsUseCase getDoctorsUseCase;
  final GetDoctorByIdUseCase getDoctorByIdUseCase;
  final CreateDoctorUseCase createDoctorUseCase;
  final UpdateDoctorUseCase updateDoctorUseCase;
  final DeleteDoctorUseCase deleteDoctorUseCase;
  final UpdateAdminProfileUseCase updateAdminProfileUseCase;
  final GetAdminStatsUseCase getAdminStatsUseCase;

  AdminCubit({
    required this.getDoctorsUseCase,
    required this.getDoctorByIdUseCase,
    required this.createDoctorUseCase,
    required this.updateDoctorUseCase,
    required this.deleteDoctorUseCase,
    required this.updateAdminProfileUseCase,
    required this.getAdminStatsUseCase,
  }) : super(AdminInitial());

  // ── Stats ─────────────────────────────────────────────────────
  Future<void> loadStats() async {
    emit(AdminLoading());
    final result = await getAdminStatsUseCase(NoParams());
    result.fold(
          (failure) => emit(AdminFailure(failure.message)),
          (stats) => emit(AdminStatsLoaded(stats)),
    );
  }

  // ── Doctors ───────────────────────────────────────────────────
  Future<void> loadDoctors() async {
    emit(AdminLoading());
    final result = await getDoctorsUseCase(NoParams());
    result.fold(
          (failure) => emit(AdminFailure(failure.message)),
          (doctors) => emit(DoctorsLoaded(doctors)),
    );
  }

  Future<void> loadDoctorById(int id) async {
    emit(AdminLoading());
    final result = await getDoctorByIdUseCase(GetDoctorByIdParams(id));
    result.fold(
          (failure) => emit(AdminFailure(failure.message)),
          (doctor) => emit(DoctorDetailLoaded(doctor)),
    );
  }

  Future<void> createDoctor({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String doctorCode,
  }) async {
    emit(AdminLoading());
    final result = await createDoctorUseCase(CreateDoctorParams(
      name: name,
      email: email,
      password: password,
      phone: phone,
      doctorCode: doctorCode,
    ));
    result.fold(
          (failure) => emit(AdminFailure(failure.message)),
          (_) => emit(const DoctorActionSuccess('Doctor created successfully')),
    );
  }

  Future<void> updateDoctor({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String doctorCode,
    String? password,
  }) async {
    emit(AdminLoading());
    final result = await updateDoctorUseCase(UpdateDoctorParams(
      id: id,
      name: name,
      email: email,
      phone: phone,
      doctorCode: doctorCode,
      password: password,
    ));
    result.fold(
          (failure) => emit(AdminFailure(failure.message)),
          (_) => emit(const DoctorActionSuccess('Doctor updated successfully')),
    );
  }

  Future<void> deleteDoctor(int id) async {
    emit(AdminLoading());
    final result = await deleteDoctorUseCase(DeleteDoctorParams(id));
    result.fold(
          (failure) => emit(AdminFailure(failure.message)),
          (_) => emit(const DoctorActionSuccess('Doctor deleted successfully')),
    );
  }

  // ── Admin Profile ─────────────────────────────────────────────
  Future<void> updateAdminProfile({
    required String name,
    required String email,
    required String phone,
    String? password,
  }) async {
    emit(AdminLoading());
    final result = await updateAdminProfileUseCase(UpdateAdminProfileParams(
      name: name,
      email: email,
      phone: phone,
      password: password,
    ));
    result.fold(
          (failure) => emit(AdminFailure(failure.message)),
          (user) => emit(AdminProfileUpdated(user)),
    );
  }
}