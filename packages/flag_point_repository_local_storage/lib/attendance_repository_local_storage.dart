import 'package:domain_repository/domain_repository.dart';
import 'package:flag_point_repository_local_storage/entity/attendance_table.dart';

import 'dao/attendance_dao.dart';

class AttendanceRepositoryLocalStorage implements AttendanceRepository {
  final AttendanceDao attendanceDao;

  AttendanceRepositoryLocalStorage(this.attendanceDao);

  @override
  Future<Attendance?> getAttendance(String id) async {
    final result = await attendanceDao.getItemsById(int.parse(id));
    Attendance? attendance;
    if (result.isNotEmpty) attendance = result.first.toEntity();
    return attendance;
  }

  @override
  Future<List<Attendance>> getAttendances() async {
    final result = await attendanceDao.getAllItems();
    final listOfEntity =
        result.map((attendance) => attendance.toEntity()).toList();
    return listOfEntity;
  }

  @override
  Future<void> setAttendance(Attendance attendance) {
    final attendanceTable = AttendanceTable.fromEntity(attendance);
    return attendanceDao.insertAttendance(attendanceTable);
  }

  @override
  Stream<List<Attendance>> watchAttendances() =>
      attendanceDao.watchAllItems().map((event) {
        if (event.isEmpty) return List.empty(growable: false);
        return event.map((e) => e.toEntity()).toList();
      });
}
