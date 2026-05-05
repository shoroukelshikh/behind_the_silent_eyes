import 'package:equatable/equatable.dart';

class PatientEntity extends Equatable {
  final int id;
  final String name;
  final int age;
  final String gender;
  final String nationalId;
  final String? phone;
  final String? dateOfBirth;
  final String? medicalHistory;
  final String? registeredOn;

  const PatientEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.nationalId,
    this.phone,
    this.dateOfBirth,
    this.medicalHistory,
    this.registeredOn,
  });

  @override
  List<Object?> get props => [id, name, age, gender, nationalId];
}