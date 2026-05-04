import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/patient_entity.dart';
import '../entities/prediction_entity.dart';

abstract class DoctorRepository {
  // Patients
  Future<Either<Failure, List<PatientEntity>>> getPatients();
  Future<Either<Failure, PatientEntity>>       getPatientById(int id);
  Future<Either<Failure, PatientEntity>>       addPatient({
    required String name,
    required int age,
    required String gender,
    required String dateOfBirth,
    required String nationalId,
    String? phone,
    String? medicalHistory,
  });
  Future<Either<Failure, PatientEntity>>  updatePatient(int id, Map<String, dynamic> data);
  Future<Either<Failure, void>>           deletePatient(int id);

  // Predictions
  Future<Either<Failure, PredictionEntity>> predict({
    required int patientId,
    required String diseaseType,
    required File image,
    String? notes,
  });
  Future<Either<Failure, List<PredictionEntity>>> getHistory(int patientId);
  Future<Either<Failure, PredictionEntity>>       getPredictionById(int id);

  // Reports
  Future<Either<Failure, String>> generateReport(int predictionId);
}