import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  // Keys
  static const String _tokenKey       = 'auth_token';
  static const String _userKey        = 'user_data';
  static const String _userRoleKey    = 'user_role';
  static const String _patientTokenKey = 'patient_token';
  static const String _patientKey     = 'patient_data';

  // ── Doctor / Admin Token ────────────────────────
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // ── Doctor / Admin User ─────────────────────────
  static Future<void> saveUser(String userJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, userJson);
  }

  static Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userRoleKey, role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  // ── Patient Token ───────────────────────────────
  static Future<void> savePatientToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_patientTokenKey, token);
  }

  static Future<String?> getPatientToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_patientTokenKey);
  }

  // ── Patient Data ────────────────────────────────
  static Future<void> savePatient(String patientJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_patientKey, patientJson);
  }

  static Future<String?> getPatient() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_patientKey);
  }

  // ── Clear ───────────────────────────────────────
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}