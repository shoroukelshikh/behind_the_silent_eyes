import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../entities/patient_entity.dart';

abstract class AuthRepository {
  // Doctor / Admin
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity>> getMe();

  // Patient
  Future<Either<Failure, PatientEntity>> patientLogin({
    required String nationalId,
  });

  Future<Either<Failure, void>> patientLogout();
}