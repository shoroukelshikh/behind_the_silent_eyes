import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/diagnose_entity.dart';
import '../repositories/patient_repository.dart';

class GetPatientDiagnosesUseCase
    extends UseCase<List<DiagnoseEntity>, NoParams> {
  final PatientRepository repository;
  GetPatientDiagnosesUseCase(this.repository);

  @override
  Future<Either<Failure, List<DiagnoseEntity>>> call(NoParams params) {
    return repository.getDiagnoses();
  }
}