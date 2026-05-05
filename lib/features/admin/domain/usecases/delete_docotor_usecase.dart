import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/admin_repository.dart';

class DeleteDoctorParams {
  final int id;
  DeleteDoctorParams(this.id);
}

class DeleteDoctorUseCase implements UseCase<void, DeleteDoctorParams> {
  final AdminRepository repository;
  DeleteDoctorUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteDoctorParams params) {
    return repository.deleteDoctor(params.id);
  }
}