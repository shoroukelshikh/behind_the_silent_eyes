import 'package:equatable/equatable.dart';

class DiagnoseEntity extends Equatable {
  final int id;
  final int patientId;
  final String diseaseType;
  final double confidence;
  final String? severity;
  final String? notes;
  final String status;
  final String? imagePath;
  final String? createdAt;

  const DiagnoseEntity({
    required this.id,
    required this.patientId,
    required this.diseaseType,
    required this.confidence,
    required this.status,
    this.severity,
    this.notes,
    this.imagePath,
    this.createdAt,
  });

  /// confidence as percentage string e.g. 0.92 → "92%"
  String get confidencePercent =>
      '${(confidence).toStringAsFixed(0)}%';

  @override
  List<Object?> get props => [id, patientId, diseaseType, confidence, status];
}