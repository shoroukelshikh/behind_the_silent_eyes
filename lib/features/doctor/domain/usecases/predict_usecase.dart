import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/prediction_entity.dart';
import '../repositories/doctor_repository.dart';

class PredictUseCase extends UseCase<PredictionEntity, PredictParams> {
  final DoctorRepository repository;
  PredictUseCase(this.repository);

  @override
  Future<Either<Failure, PredictionEntity>> call(PredictParams params) {
    return repository.predict(
      patientId:   params.patientId,
      diseaseType: params.diseaseType,
      image:       params.image,
      notes:       params.notes,
    );
  }
}

class PredictParams extends Equatable {
  final int patientId;
  final String diseaseType;
  final File image;
  final String? notes;

  const PredictParams({
    required this.patientId,
    required this.diseaseType,
    required this.image,
    this.notes,
  });

  @override
  List<Object?> get props => [patientId, diseaseType, image];
}