import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/patient_entity.dart';
import '../../domain/entities/prediction_entity.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../datasources/doctor_remote_datasource.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;
  DoctorRepositoryImpl(this.remoteDataSource);

  // ── Patients ──────────────────────────────────────────────────
  @override
  Future<Either<Failure, List<PatientEntity>>> getPatients() async {
    try {
      final patients = await remoteDataSource.getPatients();
      return Right(patients);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, PatientEntity>> getPatientById(int id) async {
    try {
      final patient = await remoteDataSource.getPatientById(id);
      return Right(patient);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, PatientEntity>> addPatient({
    required String name,
    required int age,
    required String gender,
    required String dateOfBirth,
    required String nationalId,
    String? phone,
    String? medicalHistory,
  }) async {
    try {
      final patient = await remoteDataSource.addPatient(
        name:           name,
        age:            age,
        gender:         gender,
        dateOfBirth:    dateOfBirth,
        nationalId:     nationalId,
        phone:          phone,
        medicalHistory: medicalHistory,
      );
      return Right(patient);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, PatientEntity>> updatePatient(
      int id, Map<String, dynamic> data) async {
    try {
      final patient = await remoteDataSource.updatePatient(id, data);
      return Right(patient);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, void>> deletePatient(int id) async {
    try {
      await remoteDataSource.deletePatient(id);
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  // ── Predictions ───────────────────────────────────────────────
  @override
  Future<Either<Failure, PredictionEntity>> predict({
    required int patientId,
    required String diseaseType,
    required File image,
    String? notes,
  }) async {
    try {
      final prediction = await remoteDataSource.predict(
        patientId:   patientId,
        diseaseType: diseaseType,
        image:       image,
        notes:       notes,
      );
      return Right(prediction);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, List<PredictionEntity>>> getHistory(
      int patientId) async {
    try {
      final history = await remoteDataSource.getHistory(patientId);
      return Right(history);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, PredictionEntity>> getPredictionById(int id) async {
    try {
      final prediction = await remoteDataSource.getPredictionById(id);
      return Right(prediction);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, String>> generateReport(int predictionId) async {
    try {
      final url = await remoteDataSource.generateReport(predictionId);
      return Right(url);
    } on Failure catch (f) {
      return Left(f);
    }
  }
}