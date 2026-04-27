import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/patient_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  // ── Doctor / Admin ────────────────────────────────────────────
  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email:    email,
        password: password,
      );
      return Right(user);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    try {
      final user = await remoteDataSource.getMe();
      return Right(user);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  // ── Patient ───────────────────────────────────────────────────
  @override
  Future<Either<Failure, PatientEntity>> patientLogin({
    required String nationalId,
  }) async {
    try {
      final patient = await remoteDataSource.patientLogin(
        nationalId: nationalId,
      );
      return Right(patient);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, void>> patientLogout() async {
    try {
      await remoteDataSource.patientLogout();
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    }
  }
}