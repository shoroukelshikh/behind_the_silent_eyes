import 'package:dio/dio.dart';
import '../../../../core/error/api_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/admin_stats_model.dart';
import '../models/doctor_model.dart';

class AdminRemoteDataSource {
  final Dio _dio = DioClient.instance;

  // ── Get All Doctors ───────────────────────────────────────────
  Future<List<DoctorModel>> getDoctors() async {
    try {
      final response = await _dio.get(ApiEndpoints.doctors);
      // Laravel paginate يرجع { data: [...], total: N, ... }
      final rawList = response.data['data'] ?? response.data;
      final list = rawList as List;
      return list.map((e) => DoctorModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Get Doctor By Id ─────────────────────────────────────────
  Future<DoctorModel> getDoctorById(int id) async {
    try {
      final response = await _dio.get(ApiEndpoints.doctorById(id));
      return DoctorModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Create Doctor ────────────────────────────────────────────
  Future<DoctorModel> createDoctor({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String doctorCode,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.doctors,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'doctor_code': doctorCode,
        },
      );
      return DoctorModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Update Doctor ────────────────────────────────────────────
  Future<DoctorModel> updateDoctor({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String doctorCode,
    String? password,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'phone': phone,
        'doctor_code': doctorCode,
      };
      if (password != null && password.isNotEmpty) {
        data['password'] = password;
      }

      final response = await _dio.put(
        ApiEndpoints.doctorById(id),
        data: data,
      );
      return DoctorModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Delete Doctor ────────────────────────────────────────────
  Future<void> deleteDoctor(int id) async {
    try {
      await _dio.delete(ApiEndpoints.doctorById(id));
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Update Admin Profile ─────────────────────────────────────
  Future<DoctorModel> updateAdminProfile({
    required String name,
    required String email,
    required String phone,
    String? password,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'phone': phone,
      };
      if (password != null && password.isNotEmpty) {
        data['password'] = password;
      }

      final response = await _dio.put(ApiEndpoints.profile, data: data);
      return DoctorModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Get Admin Stats ───────────────────────────────────────────
  // NOTE: This aggregates data from multiple endpoints since the backend
  // does not have a dedicated /admin/stats endpoint.
  Future<AdminStatsModel> getAdminStats() async {
    try {
      // Fetch doctors list and get total count
      final doctorsRes = await _dio.get(ApiEndpoints.doctors);
      final doctorsData = doctorsRes.data;
      final totalDoctors = (doctorsData['total'] ??
          (doctorsData['data'] as List? ?? doctorsData as List).length) as int;

      // Fetch patients list to get total count (admin has access via doctor routes)
      final patientsRes = await _dio.get(ApiEndpoints.patients);
      final patientsData = patientsRes.data;
      final totalPatients = (patientsData['total'] ??
          (patientsData['data'] as List? ?? patientsData as List).length) as int;

      return AdminStatsModel(
        totalDoctors: totalDoctors,
        totalPatients: totalPatients,
        totalPredictions: 0, // no predictions endpoint for admin yet
      );
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}