import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final String? id;
  final double lat;
  final double lon;
  final String? desc;
  final int createdAt;

  const Attendance(this.lat, this.lon, this.createdAt, {this.desc, this.id});

  @override
  List<Object?> get props => [
        id,
        lat,
        lon,
        desc,
        createdAt,
      ];
}
