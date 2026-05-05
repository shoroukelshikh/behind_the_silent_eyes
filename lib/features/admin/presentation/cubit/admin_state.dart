import 'package:equatable/equatable.dart';
import '../../domain/entities/adminstats_entity.dart';
import '../../domain/entities/doctor_entity.dart';

abstract class AdminState extends Equatable {
  const AdminState();
  @override
  List<Object?> get props => [];
}

// ── Initial ───────────────────────────────────────────────────
class AdminInitial extends AdminState {}

// ── Loading ───────────────────────────────────────────────────
class AdminLoading extends AdminState {}

// ── Stats Loaded ──────────────────────────────────────────────
class AdminStatsLoaded extends AdminState {
  final AdminStatsEntity stats;
  const AdminStatsLoaded(this.stats);
  @override
  List<Object?> get props => [stats];
}

// ── Doctors Loaded ─────────────────────────────────────────────
class DoctorsLoaded extends AdminState {
  final List<DoctorEntity> doctors;
  const DoctorsLoaded(this.doctors);
  @override
  List<Object?> get props => [doctors];
}

// ── Doctor Detail Loaded ──────────────────────────────────────
class DoctorDetailLoaded extends AdminState {
  final DoctorEntity doctor;
  const DoctorDetailLoaded(this.doctor);
  @override
  List<Object?> get props => [doctor];
}

// ── Doctor Action Success (create / update / delete) ─────────
class DoctorActionSuccess extends AdminState {
  final String message;
  const DoctorActionSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

// ── Profile Updated ───────────────────────────────────────────
class AdminProfileUpdated extends AdminState {
  final DoctorEntity user;
  const AdminProfileUpdated(this.user);
  @override
  List<Object?> get props => [user];
}

// ── Failure ───────────────────────────────────────────────────
class AdminFailure extends AdminState {
  final String message;
  const AdminFailure(this.message);
  @override
  List<Object?> get props => [message];
}