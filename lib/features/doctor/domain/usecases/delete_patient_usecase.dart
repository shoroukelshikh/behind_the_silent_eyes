import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/doctor_repository.dart';

class DeletePatientUseCase extends UseCase<void, DeletePatientParams> {
  final DoctorRepository repository;
  DeletePatientUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeletePatientParams params) {
    return repository.deletePatient(params.id);
  }
}

class DeletePatientParams extends Equatable {
  final int id;
  const DeletePatientParams({required this.id});

  @override
  List<Object?> get props => [id];
}