import 'package:domain_repository/domain_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flag_point_repository_local_storage/flag_point_repository_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit(this.attendanceRepository) : super(const AttendanceInitial());

  final AttendanceRepository attendanceRepository;
  StreamSubscription? _streamSubscription;

  factory AttendanceCubit.create(BuildContext context) =>
      AttendanceCubit(context.read<AttendanceRepositoryLocalStorage>());

  void onListenListAttendances() {
    _streamSubscription =
        attendanceRepository.watchAttendances().listen((event) {
      emit(const AttendanceRefresh());
      if (event.isEmpty) {
        emit(const EmptyAttendances());
      } else {
        emit(AttendanceList(event));
      }
    }, onError: (error) {
      emit(const AttendanceError('Get List Attendance Error'));
    });
  }

  void userAttendance(Location location) async {
    try {
      final timeStamp = DateTime.now().millisecondsSinceEpoch;
      final attendance = Attendance(location.lat, location.lon, timeStamp);
      await attendanceRepository.setAttendance(attendance);
    } catch (e) {
      emit(const AttendanceError('Failed create attendance'));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
