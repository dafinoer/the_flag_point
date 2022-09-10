import 'package:flag_point_repository_local_storage/components/constanta.dart';

import '../entity/attendance_table.dart';
import 'package:floor/floor.dart';

@dao
abstract class AttendanceDao {
  @Query('SELECT * from ${Constanta.attendanceTableName}')
  Future<List<AttendanceTable>> getAllItems();

  @Query('SELECT * from ${Constanta.attendanceTableName} WHERE id = :id')
  Future<List<AttendanceTable>> getItemsById(int id);

  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> insertAttendance(AttendanceTable attendanceTable);

  @Query('DELETE from ${Constanta.attendanceTableName}')
  Future<void> clearAll();

  @Query(
      'SELECT * FROM ${Constanta.attendanceTableName} ORDER BY timestamp DESC')
  Stream<List<AttendanceTable>> watchAllItems();
}
