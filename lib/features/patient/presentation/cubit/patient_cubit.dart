import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_patient_diagnoses_usecases.dart';
import '../../domain/usecases/get_patient_profile_usecase.dart';
import 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  final GetPatientProfileUseCase   getPatientProfileUseCase;
  final GetPatientDiagnosesUseCase getPatientDiagnosesUseCase;

  PatientCubit({
    required this.getPatientProfileUseCase,
    required this.getPatientDiagnosesUseCase,
  }) : super(const PatientState());

  Future<void> getProfile() async {
    emit(state.copyWith(isLoadingProfile: true, profileError: null));
    final result = await getPatientProfileUseCase(NoParams());
    result.fold(
          (failure) => emit(state.copyWith(
          isLoadingProfile: false, profileError: failure.message)),
          (patient) => emit(state.copyWith(
          isLoadingProfile: false, patient: patient)),
    );
  }

  Future<void> getDiagnoses() async {
    emit(state.copyWith(isLoadingDiagnoses: true, diagnosesError: null));
    final result = await getPatientDiagnosesUseCase(NoParams());
    result.fold(
          (failure) => emit(state.copyWith(
          isLoadingDiagnoses: false, diagnosesError: failure.message)),
          (diagnoses) => emit(state.copyWith(
          isLoadingDiagnoses: false, diagnoses: diagnoses)),
    );
  }
}