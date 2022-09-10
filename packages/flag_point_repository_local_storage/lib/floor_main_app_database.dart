import 'package:flag_point_repository_local_storage/flag_point_repository_local_storage.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import 'dao/attendance_dao.dart';
import 'entity/attendance_table.dart';

part 'floor_main_app_database.g.dart';

@Database(version: 1, entities: [AttendanceTable])
abstract class FloorMainAppDatabase extends FloorDatabase {
  AttendanceDao get attendanceDao;

  static late final FloorMainAppDatabase instance;
}

class FloorAppDatabase {
  static Future<void> create() async {
    FloorMainAppDatabase.instance = await $FloorFloorMainAppDatabase
        .databaseBuilder('app_database.db')
        .build();
  }
}
