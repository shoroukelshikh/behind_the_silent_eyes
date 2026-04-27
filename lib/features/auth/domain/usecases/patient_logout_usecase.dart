import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class PatientLogoutUseCase extends UseCase<void, NoParams> {
  final AuthRepository repository;
  PatientLogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.patientLogout();
  }
}