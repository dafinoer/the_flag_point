import 'dart:async';

import 'package:domain_repository/domain_repository.dart';
import 'package:flag_point_repository_local_storage/components/constanta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_repository.dart';

class PinPointRepositoryLocalStorage
    implements LocalStorageRepository<Location> {
  final SharedPreferences sharedPreferences;

  PinPointRepositoryLocalStorage(this.sharedPreferences);

  @override
  Future<void> add(Location location) {
    final latLocation = location.lat.toString();
    final lonLocation = location.lon.toString();
    return sharedPreferences.setStringList(
      Constanta.pinPointLocationKey,
      [latLocation, lonLocation],
    );
  }

  List<Location>? getPinLocation() {
    final result =
        sharedPreferences.getStringList(Constanta.pinPointLocationKey);
    if (result != null && result.isNotEmpty) {
      final latitude = double.parse(result.first);
      final longitude = double.parse(result.last);
      return List.unmodifiable([Location(longitude, latitude)]);
    }
    return null;
  }

  @override
  FutureOr<List<Location>> getItems({String? keyOfId}) {
    final pinLocations = getPinLocation();
    if (pinLocations == null) return List.empty(growable: false);
    return pinLocations;
  }

  @override
  FutureOr<Location?> getItem({String? keyId}) {
    final location =
        sharedPreferences.getStringList(Constanta.pinPointLocationKey);
    if (location != null && location.isNotEmpty) {
      final latitude = double.parse(location.first);
      final longitude = double.parse(location.last);
      return Location(longitude, latitude);
    }
    return null;
  }

  @override
  Future<void> deleteAll() =>
      sharedPreferences.remove(Constanta.pinPointLocationKey);

  @override
  Future<void> remove(Location object) =>
      sharedPreferences.remove(Constanta.pinPointLocationKey);
}
