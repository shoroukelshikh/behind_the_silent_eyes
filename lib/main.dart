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

    // ── Wire up dependencies ──────────────────────────────────
    final remoteDataSource   = AuthRemoteDataSource();
    final authRepository     = AuthRepositoryImpl(remoteDataSource);
    final doctorRemoteDataSource = DoctorRemoteDataSource();
    final doctorRepository       = DoctorRepositoryImpl(doctorRemoteDataSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(
            loginUseCase:        LoginUseCase(authRepository),
            logoutUseCase:       LogoutUseCase(authRepository),
            patientLoginUseCase: PatientLoginUseCase(authRepository),
            patientLogoutUseCase: PatientLogoutUseCase(authRepository),
            getMeUseCase: GetMeUseCase(authRepository)
          ),
        ),
        BlocProvider<DoctorCubit>(
          create: (_) => DoctorCubit(
            getPatientsUseCase:    GetPatientsUseCase(doctorRepository),
            addPatientUseCase:     AddPatientUseCase(doctorRepository),
            updatePatientUseCase:  UpdatePatientUseCase(doctorRepository),
            deletePatientUseCase:  DeletePatientUseCase(doctorRepository),
            predictUseCase:        PredictUseCase(doctorRepository),
            getHistoryUseCase:     GetHistoryUseCase(doctorRepository),
            generateReportUseCase: GenerateReportUseCase(doctorRepository),
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