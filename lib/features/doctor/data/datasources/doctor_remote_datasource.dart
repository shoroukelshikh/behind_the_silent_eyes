import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/error/api_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/patient_model.dart';
import '../models/prediction_model.dart';

class DoctorRemoteDataSource {
  final Dio _dio = DioClient.instance;

  // ── Patients ──────────────────────────────────────────────────
  Future<List<PatientModel>> getPatients() async {
    try {
      final response = await _dio.get(ApiEndpoints.patients);
      final list = (response.data['data'] ?? response.data) as List;
      return list.map((e) => PatientModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<PatientModel> getPatientById(int id) async {
    try {
      final response = await _dio.get(ApiEndpoints.patientById(id));
      return PatientModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<PatientModel> addPatient({
    required String name,
    required int age,
    required String gender,
    required String dateOfBirth,
    required String nationalId,
    String? phone,
    String? medicalHistory,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.patients,
        data: {
          'name':            name,
          'age':             age,
          'gender':          gender.toLowerCase(),
          'date_of_birth':   dateOfBirth,
          'national_id':     nationalId,
          if (phone != null) 'phone': phone,
          if (medicalHistory != null) 'medical_history': medicalHistory,
        },
      );
      return PatientModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<PatientModel> updatePatient(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(ApiEndpoints.patientById(id), data: data);
      return PatientModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> deletePatient(int id) async {
    try {
      await _dio.delete(ApiEndpoints.patientById(id));
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Predictions ───────────────────────────────────────────────
  Future<PredictionModel> predict({
    required int patientId,
    required String diseaseType,
    required File image,
    String? notes,
  }) async {
    try {
      final formData = FormData.fromMap({
        'patient_id': patientId,
        if (notes != null) 'notes': notes,
        'image': await MultipartFile.fromFile(
          image.path,
          filename: 'retinal_image.jpg',
        ),
      });

      final response = await _dio.post(
        ApiEndpoints.predict(diseaseType),
        data: formData,
      );
      print(response.data);
      return PredictionModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<List<PredictionModel>> getHistory(int patientId) async {
    try {
      final response =
      await _dio.get(ApiEndpoints.predictionHistory(patientId));
      final list = response.data as List;
      return list.map((e) => PredictionModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<PredictionModel> getPredictionById(int id) async {
    try {
      final response = await _dio.get(ApiEndpoints.predictionById(id));
      return PredictionModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Reports ───────────────────────────────────────────────────
  Future<String> generateReport(int predictionId) async {
    try {
      final response =
      await _dio.post(ApiEndpoints.generateReport(predictionId));
      return response.data['file_url'];
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}