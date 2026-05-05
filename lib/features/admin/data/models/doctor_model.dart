import '../../domain/entities/doctor_entity.dart';

class DoctorModel extends DoctorEntity {
  const DoctorModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.doctorCode,
    required super.role,
    super.createdAt,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      doctorCode: json['doctor_code'],
      role: json['role'] ?? 'doctor',
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'doctor_code': doctorCode,
      'role': role,
      'created_at': createdAt,
    };
  }
}