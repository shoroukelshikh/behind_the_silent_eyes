import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/patient_entity.dart';
import '../repositories/doctor_repository.dart';

class UpdatePatientUseCase extends UseCase<PatientEntity, UpdatePatientParams> {
  final DoctorRepository repository;
  UpdatePatientUseCase(this.repository);

  @override
  Future<Either<Failure, PatientEntity>> call(UpdatePatientParams params) {
    return repository.updatePatient(params.id, params.data);
  }
}

class UpdatePatientParams extends Equatable {
  final int id;
  final Map<String, dynamic> data;

  const UpdatePatientParams({required this.id, required this.data});

  @override
  List<Object?> get props => [id, data];
}