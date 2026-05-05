import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor_entity.dart';
import '../repositories/admin_repository.dart';

class UpdateDoctorParams {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String doctorCode;
  final String? password;

  UpdateDoctorParams({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.doctorCode,
    this.password,
  });
}

class UpdateDoctorUseCase implements UseCase<DoctorEntity, UpdateDoctorParams> {
  final AdminRepository repository;
  UpdateDoctorUseCase(this.repository);

  @override
  Future<Either<Failure, DoctorEntity>> call(UpdateDoctorParams params) {
    return repository.updateDoctor(
      id: params.id,
      name: params.name,
      email: params.email,
      phone: params.phone,
      doctorCode: params.doctorCode,
      password: params.password,
    );
  }
}