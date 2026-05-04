import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/doctor_repository.dart';

class GenerateReportUseCase extends UseCase<String, GenerateReportParams> {
  final DoctorRepository repository;
  GenerateReportUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(GenerateReportParams params) {
    return repository.generateReport(params.predictionId);
  }
}

class GenerateReportParams extends Equatable {
  final int predictionId;
  const GenerateReportParams({required this.predictionId});

  @override
  List<Object?> get props => [predictionId];
}