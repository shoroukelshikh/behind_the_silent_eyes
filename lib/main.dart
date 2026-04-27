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

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(
            loginUseCase:        LoginUseCase(authRepository),
            logoutUseCase:       LogoutUseCase(authRepository),
            patientLoginUseCase: PatientLoginUseCase(authRepository),
            patientLogoutUseCase: PatientLogoutUseCase(authRepository),
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