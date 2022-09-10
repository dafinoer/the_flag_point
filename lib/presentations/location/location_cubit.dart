import 'package:domain_repository/domain_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flag_point_repository_local_storage/local_storage_repository.dart';
import 'package:flag_point_services/flag_point_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this.locationDeviceService, this.localStorageRepository)
      : super(const LocationInitial());

  final LocationRepository locationDeviceService;
  final LocalStorageRepository<Location> localStorageRepository;

  bool _isLocationPermissionActive = false;
  Location? _locationDevice;

  factory LocationCubit.create(BuildContext context) => LocationCubit(
      context.read<LocationDeviceService>(),
      context.read<LocalStorageRepository<Location>>());

  Location? get locationDevice => _locationDevice;

  void checkPermission() async {
    _isLocationPermissionActive =
        await locationDeviceService.permissionAccessLocation();
    if (!_isLocationPermissionActive) emit(const LocationPermissionDenied());
  }

  void getLocation() async {
    try {
      emit(const LocationLoading());
      final result = await locationDeviceService.getLocation();
      final getLatLng = await localStorageRepository.getItem();
      _locationDevice = result;
      if (getLatLng == null) {
        emit(const LocationError('Please set pin location before'));
        return;
      }
      if (result != null) {
        final distance = locationDeviceService.betweenDistance(
            startLat: result.lat,
            startLon: result.lon,
            endLat: getLatLng.lat,
            endLon: getLatLng.lon);
        if (distance > 50) {
          emit(const LocationError('You Distance to Far from Pin location'));
        } else {
          emit(LocationPosition(result));
        }
      }
    } on LocationServiceDisabledException catch (e) {
      emit(LocationError(e.toString()));
    } catch (e) {
      emit(const LocationError('Opps error when get location'));
    }
  }

  void openSettingDevice() => locationDeviceService.openAppSettingPermission();
}
