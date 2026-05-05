import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/patient_entity.dart';
import '../../domain/entities/diagnose_entity.dart';

class PatientState extends Equatable {
  final PatientEntity? patient;
  final List<DiagnoseEntity>? diagnoses;
  final bool isLoadingProfile;
  final bool isLoadingDiagnoses;
  final String? profileError;
  final String? diagnosesError;

  const PatientState({
    this.patient,
    this.diagnoses,
    this.isLoadingProfile = false,
    this.isLoadingDiagnoses = false,
    this.profileError,
    this.diagnosesError,
  });

  PatientState copyWith({
    PatientEntity? patient,
    List<DiagnoseEntity>? diagnoses,
    bool? isLoadingProfile,
    bool? isLoadingDiagnoses,
    String? profileError,
    String? diagnosesError,
  }) {
    return PatientState(
      patient:            patient            ?? this.patient,
      diagnoses:          diagnoses          ?? this.diagnoses,
      isLoadingProfile:   isLoadingProfile   ?? this.isLoadingProfile,
      isLoadingDiagnoses: isLoadingDiagnoses ?? this.isLoadingDiagnoses,
      profileError:       profileError,
      diagnosesError:     diagnosesError,
    );
  }

  @override
  List<Object?> get props => [
    patient, diagnoses,
    isLoadingProfile, isLoadingDiagnoses,
    profileError, diagnosesError,
  ];
}