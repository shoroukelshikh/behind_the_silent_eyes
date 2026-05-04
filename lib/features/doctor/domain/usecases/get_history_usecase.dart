import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/prediction_entity.dart';
import '../repositories/doctor_repository.dart';

class GetHistoryUseCase extends UseCase<List<PredictionEntity>, GetHistoryParams> {
  final DoctorRepository repository;
  GetHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<PredictionEntity>>> call(GetHistoryParams params) {
    return repository.getHistory(params.patientId);
  }
}

class GetHistoryParams extends Equatable {
  final int patientId;
  const GetHistoryParams({required this.patientId});

  @override
  List<Object?> get props => [patientId];
}