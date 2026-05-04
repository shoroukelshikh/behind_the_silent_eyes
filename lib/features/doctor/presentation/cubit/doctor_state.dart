import 'package:equatable/equatable.dart';
import '../../domain/entities/patient_entity.dart';
import '../../domain/entities/prediction_entity.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object?> get props => [];
}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

// ── Patients ──────────────────────────────────────────────────
class PatientsLoaded extends DoctorState {
  final List<PatientEntity> patients;
  const PatientsLoaded(this.patients);

  @override
  List<Object?> get props => [patients];
}

class PatientAdded extends DoctorState {
  final PatientEntity patient;
  const PatientAdded(this.patient);

  @override
  List<Object?> get props => [patient];
}

class PatientUpdated extends DoctorState {
  final PatientEntity patient;
  const PatientUpdated(this.patient);

  @override
  List<Object?> get props => [patient];
}

class PatientDeleted extends DoctorState {}

// ── Predictions ───────────────────────────────────────────────
class PredictionSuccess extends DoctorState {
  final PredictionEntity prediction;
  const PredictionSuccess(this.prediction);

  @override
  List<Object?> get props => [prediction];
}

class HistoryLoaded extends DoctorState {
  final List<PredictionEntity> predictions;
  const HistoryLoaded(this.predictions);

  @override
  List<Object?> get props => [predictions];
}

// ── Reports ───────────────────────────────────────────────────
class ReportGenerated extends DoctorState {
  final String fileUrl;
  const ReportGenerated(this.fileUrl);

  @override
  List<Object?> get props => [fileUrl];
}

// ── Error ─────────────────────────────────────────────────────
class DoctorFailure extends DoctorState {
  final String message;
  const DoctorFailure(this.message);

  @override
  List<Object?> get props => [message];
}