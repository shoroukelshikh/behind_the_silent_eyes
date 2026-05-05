import 'package:behind_silent_eyes/features/admin/data/datasources/admin_remote_datasource.dart';
import 'package:behind_silent_eyes/features/admin/data/repositories/admin_repository_impl.dart';
import 'package:behind_silent_eyes/features/admin/domain/usecases/create_doctor_usecase.dart';
import 'package:behind_silent_eyes/features/admin/domain/usecases/get_admin_stats_usecase.dart';
import 'package:behind_silent_eyes/features/admin/domain/usecases/get_doctors_usecase.dart';
import 'package:behind_silent_eyes/features/admin/domain/usecases/update_admin_profile_usecase.dart';
import 'package:behind_silent_eyes/features/admin/domain/usecases/update_doctor_usecase.dart';
import 'package:behind_silent_eyes/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:behind_silent_eyes/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:behind_silent_eyes/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:behind_silent_eyes/features/auth/domain/usecases/login_usecase.dart';
import 'package:behind_silent_eyes/features/auth/domain/usecases/logout_usecase.dart';
import 'package:behind_silent_eyes/features/auth/domain/usecases/patient_login_usecase.dart';
import 'package:behind_silent_eyes/features/auth/domain/usecases/patient_logout_usecase.dart';
import 'package:behind_silent_eyes/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:behind_silent_eyes/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/admin/domain/usecases/delete_docotor_usecase.dart';
import 'features/admin/domain/usecases/get_doctor_byId_usecase.dart';
import 'features/auth/domain/usecases/get_me_usecase.dart';
import 'features/doctor/data/datasources/doctor_remote_datasource.dart';
import 'features/doctor/data/repositories/doctor_repository_impl.dart';
import 'features/doctor/domain/usecases/add_patient_usecase.dart';
import 'features/doctor/domain/usecases/delete_patient_usecase.dart';
import 'features/doctor/domain/usecases/generate_report_usecase.dart';
import 'features/doctor/domain/usecases/get_history_usecase.dart';
import 'features/doctor/domain/usecases/get_patients_usecase.dart';
import 'features/doctor/domain/usecases/predict_usecase.dart';
import 'features/doctor/domain/usecases/update_patient_usecase.dart';
import 'features/doctor/presentation/cubit/doctor_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ── Auth ──────────────────────────────────────────────────
    final remoteDataSource = AuthRemoteDataSource();
    final authRepository = AuthRepositoryImpl(remoteDataSource);

    // ── Doctor ────────────────────────────────────────────────
    final doctorRemoteDataSource = DoctorRemoteDataSource();
    final doctorRepository = DoctorRepositoryImpl(doctorRemoteDataSource);

    // ── Admin ─────────────────────────────────────────────────
    final adminRemoteDataSource = AdminRemoteDataSource();
    final adminRepository = AdminRepositoryImpl(adminRemoteDataSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(
            loginUseCase: LoginUseCase(authRepository),
            logoutUseCase: LogoutUseCase(authRepository),
            patientLoginUseCase: PatientLoginUseCase(authRepository),
            patientLogoutUseCase: PatientLogoutUseCase(authRepository),
            getMeUseCase: GetMeUseCase(authRepository),
          ),
        ),
        BlocProvider<DoctorCubit>(
          create: (_) => DoctorCubit(
            getPatientsUseCase: GetPatientsUseCase(doctorRepository),
            addPatientUseCase: AddPatientUseCase(doctorRepository),
            updatePatientUseCase: UpdatePatientUseCase(doctorRepository),
            deletePatientUseCase: DeletePatientUseCase(doctorRepository),
            predictUseCase: PredictUseCase(doctorRepository),
            getHistoryUseCase: GetHistoryUseCase(doctorRepository),
            generateReportUseCase: GenerateReportUseCase(doctorRepository),
          ),
        ),
        BlocProvider<AdminCubit>(
          create: (_) => AdminCubit(
            getDoctorsUseCase: GetDoctorsUseCase(adminRepository),
            getDoctorByIdUseCase: GetDoctorByIdUseCase(adminRepository),
            createDoctorUseCase: CreateDoctorUseCase(adminRepository),
            updateDoctorUseCase: UpdateDoctorUseCase(adminRepository),
            deleteDoctorUseCase: DeleteDoctorUseCase(adminRepository),
            updateAdminProfileUseCase:
            UpdateAdminProfileUseCase(adminRepository),
            getAdminStatsUseCase: GetAdminStatsUseCase(adminRepository),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}