import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/patient_entity.dart';
import '../repositories/auth_repository.dart';

class PatientLoginUseCase extends UseCase<PatientEntity, PatientLoginParams> {
  final AuthRepository repository;
  PatientLoginUseCase(this.repository);

  @override
  Future<Either<Failure, PatientEntity>> call(PatientLoginParams params) {
    return repository.patientLogin(nationalId: params.nationalId);
  }
}

class PatientLoginParams extends Equatable {
  final String nationalId;
  const PatientLoginParams({required this.nationalId});

  @override
  List<Object> get props => [nationalId];
}