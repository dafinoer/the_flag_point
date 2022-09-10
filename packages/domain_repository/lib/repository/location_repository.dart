import 'dart:async';

import '../model/location.dart';

abstract class LocationRepository {
  Future<void> setPinLocation(Location pinLocation);

  FutureOr<Location?> getLocation();

  Future<bool> permissionAccessLocation();

  double betweenDistance({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  });

  Future<void> openAppSettingPermission();
}
