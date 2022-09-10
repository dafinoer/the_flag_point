part of 'attendance_cubit.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {
  const AttendanceInitial();

  @override
  List<Object?> get props => [];
}

class AttendanceLoading extends AttendanceState {
  const AttendanceLoading();

  @override
  List<Object?> get props => [];
}

class AttendanceSuccess extends AttendanceState {
  const AttendanceSuccess();

  @override
  List<Object?> get props => [];
}

class AttendanceRefresh extends AttendanceState {
  const AttendanceRefresh();

  @override
  List<Object?> get props => [];
}

class EmptyAttendances extends AttendanceState {
  const EmptyAttendances();

  @override
  List<Object?> get props => [];
}

class AttendanceList extends AttendanceState {
  final List<Attendance> attendances;

  const AttendanceList(this.attendances);

  @override
  List<Object?> get props => [attendances];
}

class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError(this.message);

  @override
  List<Object?> get props => [message];
}
