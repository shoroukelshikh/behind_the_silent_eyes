import 'dart:convert';

import '../../domain/entities/user_entity.dart';


class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.phone,
    super.doctorCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:         json['id'],
      name:       json['name'],
      email:      json['email'],
      role:       json['role'],
      phone:      json['phone'],
      doctorCode: json['doctor_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':          id,
      'name':        name,
      'email':       email,
      'role':        role,
      'phone':       phone,
      'doctor_code': doctorCode,
    };
  }

  // عشان نحفظه في LocalStorage
  String toJsonString() => jsonEncode(toJson());

  factory UserModel.fromJsonString(String jsonString) {
    return UserModel.fromJson(jsonDecode(jsonString));
  }
}