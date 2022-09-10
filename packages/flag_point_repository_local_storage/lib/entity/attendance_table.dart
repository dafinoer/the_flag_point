import 'package:domain_repository/domain_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'Attendance', primaryKeys: ['id'])
class AttendanceTable extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? desc;

  @ColumnInfo(name: 'latitude')
  final double lat;

  @ColumnInfo(name: 'longitude')
  final double lon;

  final int timestamp;

  const AttendanceTable(this.lon, this.lat, this.timestamp,
      {this.id, this.desc});

  factory AttendanceTable.fromEntity(Attendance attendance) {
    final int? id = attendance.id != null ? int.parse(attendance.id!) : null;

    return AttendanceTable(
      attendance.lon,
      attendance.lat,
      attendance.createdAt,
      id: id,
      desc: attendance.desc,
    );
  }

  Attendance toEntity() {
    final String? idColumn = id?.toString();
    return Attendance(lat, lon, timestamp, desc: desc, id: idColumn);
  }

  @override
  List<Object?> get props => [id, lat, lon, timestamp, desc];
}
