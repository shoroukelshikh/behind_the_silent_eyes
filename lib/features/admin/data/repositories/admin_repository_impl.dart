import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/adminstats_entity.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/repositories/admin_repository.dart';
import '../datasources/admin_remote_datasource.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctors() async {
    try {
      final doctors = await remoteDataSource.getDoctors();
      return Right(doctors);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, DoctorEntity>> getDoctorById(int id) async {
    try {
      final doctor = await remoteDataSource.getDoctorById(id);
      return Right(doctor);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, DoctorEntity>> createDoctor({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String doctorCode,
  }) async {
    try {
      final doctor = await remoteDataSource.createDoctor(
        name: name,
        email: email,
        password: password,
        phone: phone,
        doctorCode: doctorCode,
      );
      return Right(doctor);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, DoctorEntity>> updateDoctor({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String doctorCode,
    String? password,
  }) async {
    try {
      final doctor = await remoteDataSource.updateDoctor(
        id: id,
        name: name,
        email: email,
        phone: phone,
        doctorCode: doctorCode,
        password: password,
      );
      return Right(doctor);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, void>> deleteDoctor(int id) async {
    try {
      await remoteDataSource.deleteDoctor(id);
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, DoctorEntity>> updateAdminProfile({
    required String name,
    required String email,
    required String phone,
    String? password,
  }) async {
    try {
      final user = await remoteDataSource.updateAdminProfile(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
      return Right(user);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, AdminStatsEntity>> getAdminStats() async {
    try {
      final stats = await remoteDataSource.getAdminStats();
      return Right(stats);
    } on Failure catch (f) {
      return Left(f);
    }
  }
}