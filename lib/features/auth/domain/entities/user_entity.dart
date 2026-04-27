import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? phone;
  final String? doctorCode;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.doctorCode,
  });

  bool get isAdmin  => role == 'admin';
  bool get isDoctor => role == 'doctor';

  @override
  List<Object?> get props => [id, name, email, role, phone, doctorCode];
}