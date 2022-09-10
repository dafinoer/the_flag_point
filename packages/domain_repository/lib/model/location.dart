import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double lat;
  final double lon;

  const Location(this.lon, this.lat);

  @override
  List<Object?> get props => [lat, lon];
}
