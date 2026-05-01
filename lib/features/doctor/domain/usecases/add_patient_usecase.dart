import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/patient_entity.dart';
import '../repositories/doctor_repository.dart';

class AddPatientUseCase extends UseCase<PatientEntity, AddPatientParams> {
  final DoctorRepository repository;
  AddPatientUseCase(this.repository);

  @override
  Future<Either<Failure, PatientEntity>> call(AddPatientParams params) {
    return repository.addPatient(
      name:          params.name,
      age:           params.age,
      gender:        params.gender,
      dateOfBirth:   params.dateOfBirth,
      nationalId:    params.nationalId,
      phone:         params.phone,
      medicalHistory: params.medicalHistory,
    );
  }
}

class AddPatientParams extends Equatable {
  final String name;
  final int age;
  final String gender;
  final String dateOfBirth;
  final String nationalId;
  final String? phone;
  final String? medicalHistory;

  const AddPatientParams({
    required this.name,
    required this.age,
    required this.gender,
    required this.dateOfBirth,
    required this.nationalId,
    this.phone,
    this.medicalHistory,
  });

  @override
  List<Object?> get props => [name, age, gender, dateOfBirth, nationalId];
}