import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/patient_entity.dart';
import '../entities/diagnose_entity.dart';

abstract class PatientRepository {
  Future<Either<Failure, PatientEntity>> getProfile();
  Future<Either<Failure, List<DiagnoseEntity>>> getDiagnoses();
}