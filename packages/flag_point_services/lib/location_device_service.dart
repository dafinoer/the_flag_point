import 'dart:async';
import 'dart:io';

import 'package:domain_repository/domain_repository.dart';
import 'package:geolocator/geolocator.dart';

class LocationDeviceService implements LocationRepository {
  bool _isServiceLocationEnable = false;

  bool get locationEnable => _isServiceLocationEnable;

  @override
  FutureOr<Location?> getLocation() async {
    if (!_isServiceLocationEnable) {
      return Future.error(const LocationServiceDisabledException());
    }
    final isAndroid = Platform.isAndroid;
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: isAndroid);
    final location = Location(position.longitude, position.latitude);
    return location;
  }

  @override
  Future<bool> permissionAccessLocation() async {
    final locationPermission = await Geolocator.checkPermission();
    switch (locationPermission) {
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
        final result = await Geolocator.requestPermission();
        if (result == LocationPermission.always ||
            result == LocationPermission.whileInUse) {
          _isServiceLocationEnable = true;
        } else {
          _isServiceLocationEnable = false;
        }
        break;
      default:
        _isServiceLocationEnable = true;
        break;
    }
    return _isServiceLocationEnable;
  }

  @override
  Future<void> setPinLocation(Location pinLocation) {
    throw UnimplementedError();
  }

  @override
  double betweenDistance({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  }) {
    final distance = Geolocator.distanceBetween(
      startLat,
      startLon,
      endLat,
      endLon,
    );
    return distance;
  }

  @override
  Future<void> openAppSettingPermission() {
    return Geolocator.openLocationSettings();
  }
}
