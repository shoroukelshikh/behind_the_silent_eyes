import 'package:dio/dio.dart';
import '../../../../core/error/api_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../auth/data/models/patient_model.dart';
import '../models/diagnose_model.dart';

class PatientRemoteDataSource {
  final Dio _dio = DioClient.instance;

  // ── Profile ───────────────────────────────────────────────────
  Future<PatientModel> getProfile() async {
    try {
      final response = await _dio.get(ApiEndpoints.patientProfile);
      // Backend returns: { status: true, data: { ...patient } }
      final data = response.data['data'] ?? response.data;
      return PatientModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Diagnoses ─────────────────────────────────────────────────
  Future<List<DiagnoseModel>> getDiagnoses() async {
    try {
      final response = await _dio.get(ApiEndpoints.patientDiagnoses);
      // Backend returns: { status: true, data: [ ...predictions ] }
      final list = (response.data['data'] ?? response.data) as List;
      return list.map((e) => DiagnoseModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}