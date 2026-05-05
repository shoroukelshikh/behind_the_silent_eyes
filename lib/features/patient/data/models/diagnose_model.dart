import '../../domain/entities/diagnose_entity.dart';

class DiagnoseModel extends DiagnoseEntity {
  const DiagnoseModel({
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

  factory DiagnoseModel.fromJson(Map<String, dynamic> json) {
    return DiagnoseModel(
      id:          int.tryParse(json['id'].toString()) ?? 0,
      patientId:   int.tryParse(json['patient_id'].toString()) ?? 0,
      diseaseType: json['disease_type'] ?? '',
      confidence:  (json['confidence'] as num?)?.toDouble() ?? 0.0,
      severity:    json['severity'],
      notes:       json['notes'],
      imagePath:   json['image_path'],
      status:      json['status'] ?? '',
      createdAt:   json['created_at']?.toString().split('T').first,
    );
  }

  Map<String, dynamic> toDisplayMap() => {
    'id':         id,
    'disease':    diseaseType,
    'severity':   severity ?? '-',
    'confidence': confidencePercent,
    'date':       createdAt ?? '-',
    'status':     status,
    'image_path': imagePath ?? '',
    'notes':      notes ?? '',
  };
}