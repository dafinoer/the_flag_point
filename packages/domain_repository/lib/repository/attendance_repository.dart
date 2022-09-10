import '../model/attendance.dart';

abstract class AttendanceRepository {
  Stream<List<Attendance>> watchAttendances();

  Future<List<Attendance>> getAttendances();

  Future<Attendance?> getAttendance(String id);

  Future<void> setAttendance(Attendance attendance);
}
