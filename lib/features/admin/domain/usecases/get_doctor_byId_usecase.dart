import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor_entity.dart';
import '../repositories/admin_repository.dart';

class GetDoctorByIdParams {
  final int id;
  GetDoctorByIdParams(this.id);
}

class GetDoctorByIdUseCase implements UseCase<DoctorEntity, GetDoctorByIdParams> {
  final AdminRepository repository;
  GetDoctorByIdUseCase(this.repository);

  @override
  Future<Either<Failure, DoctorEntity>> call(GetDoctorByIdParams params) {
    return repository.getDoctorById(params.id);
  }
}