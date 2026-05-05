import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/adminstats_entity.dart';
import '../repositories/admin_repository.dart';

class GetAdminStatsUseCase implements UseCase<AdminStatsEntity, NoParams> {
  final AdminRepository repository;
  GetAdminStatsUseCase(this.repository);

  @override
  Future<Either<Failure, AdminStatsEntity>> call(NoParams params) {
    return repository.getAdminStats();
  }
}