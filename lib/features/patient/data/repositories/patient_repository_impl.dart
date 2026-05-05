import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/patient_entity.dart';
import '../../domain/entities/diagnose_entity.dart';
import '../../domain/repositories/patient_repository.dart';
import '../datasources/patient_remote_datasource.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource remoteDataSource;
  PatientRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PatientEntity>> getProfile() async {
    try {
      final patient = await remoteDataSource.getProfile();
      return Right(patient);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, List<DiagnoseEntity>>> getDiagnoses() async {
    try {
      final diagnoses = await remoteDataSource.getDiagnoses();
      return Right(diagnoses);
    } on Failure catch (f) {
      return Left(f);
    }
  }
}