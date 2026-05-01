import 'package:equatable/equatable.dart';

class PredictionEntity extends Equatable {
  final int id;
  final int patientId;
  final String diseaseType;
  final double confidence;
  final String? severity;
  final String? notes;
  final String status;
  final String? imagePath;
  final String? createdAt;

  const PredictionEntity({
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

  // confidence كـ percentage مثلاً 0.92 → "92%"
  String get confidencePercent =>
      '${(confidence * 1).toStringAsFixed(0)}%';

  @override
  List<Object?> get props => [id, patientId, diseaseType, confidence, status];
}