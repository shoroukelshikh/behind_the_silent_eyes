import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../auth/domain/entities/patient_entity.dart';
import '../repositories/patient_repository.dart';

class GetPatientProfileUseCase extends UseCase<PatientEntity, NoParams> {
  final PatientRepository repository;
  GetPatientProfileUseCase(this.repository);

  @override
  Future<Either<Failure, PatientEntity>> call(NoParams params) {
    return repository.getProfile();
  }
}