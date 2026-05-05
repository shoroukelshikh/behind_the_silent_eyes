import '../../domain/entities/adminstats_entity.dart';
class AdminStatsModel extends AdminStatsEntity {
  const AdminStatsModel({
    required super.totalDoctors,
    required super.totalPatients,
    required super.totalPredictions,
  });

  factory AdminStatsModel.fromJson(Map<String, dynamic> json) {
    return AdminStatsModel(
      totalDoctors: json['total_doctors'] ?? 0,
      totalPatients: json['total_patients'] ?? 0,
      totalPredictions: json['total_predictions'] ?? 0,
    );
  }
}