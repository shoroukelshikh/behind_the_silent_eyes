import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor_entity.dart';
import '../repositories/admin_repository.dart';

class CreateDoctorParams {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String doctorCode;

  CreateDoctorParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.doctorCode,
  });
}

class CreateDoctorUseCase implements UseCase<DoctorEntity, CreateDoctorParams> {
  final AdminRepository repository;
  CreateDoctorUseCase(this.repository);

  @override
  Future<Either<Failure, DoctorEntity>> call(CreateDoctorParams params) {
    return repository.createDoctor(
      name: params.name,
      email: params.email,
      password: params.password,
      phone: params.phone,
      doctorCode: params.doctorCode,
    );
  }
}