import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/patient_entity.dart';
import '../repositories/doctor_repository.dart';

class GetPatientsUseCase extends UseCase<List<PatientEntity>, NoParams> {
  final DoctorRepository repository;
  GetPatientsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PatientEntity>>> call(NoParams params) {
    return repository.getPatients();
  }
}