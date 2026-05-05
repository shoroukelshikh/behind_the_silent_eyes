import 'package:dio/dio.dart';
import '../../../../core/error/api_error_handler.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/local_storage.dart';
import '../models/patient_model.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final Dio _dio = DioClient.instance;

  // ── Doctor / Admin Login ──────────────────────────────────────
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      final user = UserModel.fromJson(response.data['user']);

      // حفظ التوكن والـ user في LocalStorage
      await LocalStorage.saveToken(response.data['token']);
      await LocalStorage.saveUser(user.toJsonString());
      await LocalStorage.saveRole(user.role);

      return user;
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Doctor / Admin Logout ─────────────────────────────────────
  Future<void> logout() async {
    try {
      await _dio.post(ApiEndpoints.logout);
      await LocalStorage.clearAll();
    } on DioException catch (e) {
      // حتى لو فشل الـ request بنمسح الـ local data
      await LocalStorage.clearAll();
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Get Current User ──────────────────────────────────────────
  Future<UserModel> getMe() async {
    try {
      final response = await _dio.get(ApiEndpoints.me);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Patient Login ─────────────────────────────────────────────
  Future<PatientModel> patientLogin({required String nationalId}) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.patientLogin,
        data: {'national_id': nationalId},
      );

      final patient = PatientModel.fromJson(response.data['patient']);

      // حفظ الـ patient token والـ patient data
      await LocalStorage.savePatientToken(response.data['token']);
      await LocalStorage.savePatient(patient.toJsonString());

      return patient;
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // ── Patient Logout ────────────────────────────────────────────
  Future<void> patientLogout() async {
    try {
      await _dio.post(ApiEndpoints.patientLogout);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    } finally {
      // دايماً بنمسح الـ patient data حتى لو فشل الـ request
      final prefs = await LocalStorage.getPatientToken();
      if (prefs != null) {
        await LocalStorage.clearAll();
      }
    }
  }
}