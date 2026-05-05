import 'package:equatable/equatable.dart';

class AdminStatsEntity extends Equatable {
  final int totalDoctors;
  final int totalPatients;
  final int totalPredictions;

  const AdminStatsEntity({
    required this.totalDoctors,
    required this.totalPatients,
    required this.totalPredictions,
  });

  @override
  List<Object?> get props => [totalDoctors, totalPatients, totalPredictions];
}