import 'dart:convert';
import '../../domain/entities/patient_entity.dart';

class PatientModel extends PatientEntity {
  const PatientModel({
    required super.id,
    required super.name,
    required super.age,
    required super.gender,
    required super.nationalId,
    super.phone,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id:         json['id'],
      name:       json['name'],
      age:        json['age'],
      gender:     json['gender'],
      nationalId: json['national_id'],
      phone:      json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':          id,
      'name':        name,
      'age':         age,
      'gender':      gender,
      'national_id': nationalId,
      'phone':       phone,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  factory PatientModel.fromJsonString(String jsonString) {
    return PatientModel.fromJson(jsonDecode(jsonString));
  }
}