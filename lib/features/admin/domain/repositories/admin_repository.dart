import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/adminstats_entity.dart';
import '../entities/doctor_entity.dart';

abstract class AdminRepository {
  // Doctors CRUD
  Future<Either<Failure, List<DoctorEntity>>> getDoctors();
  Future<Either<Failure, DoctorEntity>> getDoctorById(int id);
  Future<Either<Failure, DoctorEntity>> createDoctor({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String doctorCode,
  });
  Future<Either<Failure, DoctorEntity>> updateDoctor({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String doctorCode,
    String? password,
  });
  Future<Either<Failure, void>> deleteDoctor(int id);

  // Admin Profile
  Future<Either<Failure, DoctorEntity>> updateAdminProfile({
    required String name,
    required String email,
    required String phone,
    String? password,
  });

  // Stats
  Future<Either<Failure, AdminStatsEntity>> getAdminStats();
}