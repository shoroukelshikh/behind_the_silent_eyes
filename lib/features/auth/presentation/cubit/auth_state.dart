import 'package:equatable/equatable.dart';
import '../../domain/entities/patient_entity.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class PatientAuthSuccess extends AuthState {
  final PatientEntity patient;
  const PatientAuthSuccess(this.patient);

  @override
  List<Object?> get props => [patient];
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class LogoutSuccess extends AuthState {}