import '../../domain/entities/prediction_entity.dart';

class PredictionModel extends PredictionEntity {
  const PredictionModel({
    required super.id,
    required super.patientId,
    required super.diseaseType,
    required super.confidence,
    required super.status,
    super.severity,
    super.notes,
    super.imagePath,
    super.createdAt,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      patientId: int.tryParse(json['patient_id'].toString()) ?? 0,
      diseaseType: json['disease_type'],
      confidence:  (json['confidence'] as num).toDouble(),
      severity:    json['severity'],
      notes:       json['notes'],
      imagePath:   json['image_path'],
      status:      json['status'],
      createdAt:   json['created_at']?.toString().split('T').first,
    );
  }

  // عشان نبعته للـ screens كـ Map<String, dynamic>
  Map<String, dynamic> toDisplayMap() => {
    'id':         id,
    'disease':    diseaseType,
    'severity':   severity ?? '-',
    'confidence': confidencePercent,
    'date':       createdAt ?? '-',
    'status':     status,
  };
}