import 'package:behind_silent_eyes/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/patient_login_usecase.dart';
import '../../domain/usecases/patient_logout_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase        loginUseCase;
  final LogoutUseCase       logoutUseCase;
  final PatientLoginUseCase patientLoginUseCase;
  final PatientLogoutUseCase patientLogoutUseCase;
  final GetMeUseCase getMeUseCase;


  AuthCubit({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.patientLoginUseCase,
    required this.patientLogoutUseCase,
    required this.getMeUseCase
  }) : super(AuthInitial());

  // ── Doctor / Admin Login ──────────────────────────────────────
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      LoginParams(email: email, password: password),
    );

    result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (user)    => emit(AuthSuccess(user)),
    );
  }

  // ── Doctor / Admin Logout ─────────────────────────────────────
  Future<void> logout() async {
    emit(AuthLoading());

    final result = await logoutUseCase(NoParams());

    result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (_)       => emit(LogoutSuccess()),
    );
  }

  // ── Patient Login ─────────────────────────────────────────────
  Future<void> patientLogin({required String nationalId}) async {
    emit(AuthLoading());

    final result = await patientLoginUseCase(
      PatientLoginParams(nationalId: nationalId),
    );

    result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (patient) => emit(PatientAuthSuccess(patient)),
    );
  }

  // ── Patient Logout ────────────────────────────────────────────
  Future<void> patientLogout() async {
    final result = await patientLogoutUseCase(NoParams());

    result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (_)       => emit(LogoutSuccess()),
    );
  }

  Future<void> getMe() async {
    emit(AuthLoading());
    final result = await getMeUseCase(NoParams());
    result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (user)    => emit(AuthSuccess(user)),
    );
  }
}