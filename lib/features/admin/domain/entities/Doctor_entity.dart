import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? doctorCode;
  final String role;
  final String? createdAt;

  const DoctorEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.doctorCode,
    required this.role,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, email, phone, doctorCode, role, createdAt];
}