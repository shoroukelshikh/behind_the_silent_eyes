import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor_entity.dart';
import '../repositories/admin_repository.dart';

class GetDoctorsUseCase implements UseCase<List<DoctorEntity>, NoParams> {
  final AdminRepository repository;
  GetDoctorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(NoParams params) {
    return repository.getDoctors();
  }
}