class ApiEndpoints {
  ApiEndpoints._();

  // Base
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // Auth
  static const String login   = '/auth/login';
  static const String logout  = '/auth/logout';
  static const String me      = '/auth/me';
  static const String profile = '/auth/profile';

  // Patient Auth
  static const String patientLogin  = '/patient/login';
  static const String patientLogout = '/patient/logout';
  static const String patientProfile    = '/patient/profile';
  static const String patientDiagnoses  = '/patient/diagnoses';
  static const String patientReports    = '/patient/reports';

  // Patients (Doctor)
  static const String patients = '/mobile/patients';
  static String patientById(int id) => '/mobile/patients/$id';

  // Predictions
  static String predict(String type)       => '/mobile/predictions/$type';
  static String predictionHistory(int pid) => '/mobile/predictions/history/$pid';
  static String predictionById(int id)     => '/mobile/predictions/$id';

  // Reports
  static String reportById(int id)       => '/mobile/reports/$id';
  static String generateReport(int id)   => '/mobile/reports/$id/generate';

  // Doctors (Admin only)
  static const String doctors = '/mobile/doctors';
  static String doctorById(int id) => '/mobile/doctors/$id';
}