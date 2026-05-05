import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor_entity.dart';
import '../repositories/admin_repository.dart';

class UpdateAdminProfileParams {
  final String name;
  final String email;
  final String phone;
  final String? password;

  UpdateAdminProfileParams({
    required this.name,
    required this.email,
    required this.phone,
    this.password,
  });
}

class UpdateAdminProfileUseCase
    implements UseCase<DoctorEntity, UpdateAdminProfileParams> {
  final AdminRepository repository;
  UpdateAdminProfileUseCase(this.repository);

  @override
  Future<Either<Failure, DoctorEntity>> call(UpdateAdminProfileParams params) {
    return repository.updateAdminProfile(
      name: params.name,
      email: params.email,
      phone: params.phone,
      password: params.password,
    );
  }
}