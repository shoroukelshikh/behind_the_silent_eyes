import 'dart:convert';
import '../../domain/entities/patient_entity.dart';

class PatientModel extends PatientEntity {
  const PatientModel({
    required super.id,
    required super.name,
    required super.age,
    required super.gender,
    required super.nationalId,
    required super.dateOfBirth,
    super.phone,
    super.medicalHistory,
    super.registeredOn,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id:             json['id'],
      name:           json['name'],
      age:            json['age'],
      gender:         json['gender'],
      nationalId:     json['national_id'],
      dateOfBirth:    json['date_of_birth'],
      phone:          json['phone'],
      medicalHistory: json['medical_history'],
      registeredOn:   json['created_at']?.toString().split('T').first,
    );
  }

  Map<String, dynamic> toJson() => {
    'id':              id,
    'name':            name,
    'age':             age,
    'gender':          gender,
    'national_id':     nationalId,
    'date_of_birth':   dateOfBirth,
    'phone':           phone,
    'medical_history': medicalHistory,
    'created_at':      registeredOn,
  };

  // عشان نبعته للـ screens كـ Map<String, String>
  Map<String, String> toStringMap() => {
    'id':              id.toString(),
    'name':            name,
    'age':             age.toString(),
    'gender':          gender,
    'national_id':     nationalId,
    'date_of_birth':   dateOfBirth,
    'phone':           phone ?? '',
    'medical_history': medicalHistory ?? '',
    'registered_on':   registeredOn ?? '',
  };
}