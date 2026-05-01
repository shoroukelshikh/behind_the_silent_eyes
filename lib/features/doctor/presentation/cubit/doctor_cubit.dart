import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/add_patient_usecase.dart';
import '../../domain/usecases/delete_patient_usecase.dart';
import '../../domain/usecases/generate_report_usecase.dart';
import '../../domain/usecases/get_history_usecase.dart';
import '../../domain/usecases/get_patients_usecase.dart';
import '../../domain/usecases/predict_usecase.dart';
import '../../domain/usecases/update_patient_usecase.dart';
import 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final GetPatientsUseCase    getPatientsUseCase;
  final AddPatientUseCase     addPatientUseCase;
  final UpdatePatientUseCase  updatePatientUseCase;
  final DeletePatientUseCase  deletePatientUseCase;
  final PredictUseCase        predictUseCase;
  final GetHistoryUseCase     getHistoryUseCase;
  final GenerateReportUseCase generateReportUseCase;

  DoctorCubit({
    required this.getPatientsUseCase,
    required this.addPatientUseCase,
    required this.updatePatientUseCase,
    required this.deletePatientUseCase,
    required this.predictUseCase,
    required this.getHistoryUseCase,
    required this.generateReportUseCase,
  }) : super(DoctorInitial());

  // ── Patients ──────────────────────────────────────────────────
  Future<void> getPatients() async {
    emit(DoctorLoading());
    final result = await getPatientsUseCase(NoParams());
    result.fold(
          (failure) => emit(DoctorFailure(failure.message)),
          (patients) => emit(PatientsLoaded(patients)),
    );
  }

  Future<void> addPatient({
    required String name,
    required int age,
    required String gender,
    required String dateOfBirth,
    required String nationalId,
    String? phone,
    String? medicalHistory,
  }) async {
    emit(DoctorLoading());
    final result = await addPatientUseCase(
      AddPatientParams(
        name:           name,
        age:            age,
        gender:         gender,
        dateOfBirth:    dateOfBirth,
        nationalId:     nationalId,
        phone:          phone,
        medicalHistory: medicalHistory,
      ),
    );
    result.fold(
          (failure) => emit(DoctorFailure(failure.message)),
          (patient) => emit(PatientAdded(patient)),
    );
  }

  Future<void> updatePatient(int id, Map<String, dynamic> data) async {
    emit(DoctorLoading());
    final result = await updatePatientUseCase(
      UpdatePatientParams(id: id, data: data),
    );
    result.fold(
          (failure) => emit(DoctorFailure(failure.message)),
          (patient) => emit(PatientUpdated(patient)),
    );
  }

  Future<void> deletePatient(int id) async {
    emit(DoctorLoading());
    final result = await deletePatientUseCase(
      DeletePatientParams(id: id),
    );
    result.fold(
          (failure) => emit(DoctorFailure(failure.message)),
          (_)       => emit(PatientDeleted()),
    );
  }

  // ── Predictions ───────────────────────────────────────────────
  Future<void> predict({
    required int patientId,
    required String diseaseType,
    required File image,
    String? notes,
  }) async {
    emit(DoctorLoading());

    final result = await predictUseCase(
      PredictParams(
        patientId:   patientId,
        diseaseType: diseaseType,
        image:       image,
        notes:       notes,
      ),
    );
    result.fold(
          (failure) => emit(DoctorFailure(failure.message)),
          (prediction) => emit(PredictionSuccess(prediction)),
    );
  }

  Future<void> getHistory(int patientId) async {
    emit(DoctorLoading());
    final result = await getHistoryUseCase(
      GetHistoryParams(patientId: patientId),
    );
    result.fold(
          (failure) => emit(DoctorFailure(failure.message)),
          (history) => emit(HistoryLoaded(history)),
    );
  }

  // ── Reports ───────────────────────────────────────────────────
  Future<void> generateReport(int predictionId) async {
    emit(DoctorLoading());
    final result = await generateReportUseCase(
      GenerateReportParams(predictionId: predictionId),
    );
    result.fold(
          (failure) => emit(DoctorFailure(failure.message)),
          (url)     => emit(ReportGenerated(url)),
    );
  }
}