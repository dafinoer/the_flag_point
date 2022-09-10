import 'package:bloc/bloc.dart';
import 'package:domain_repository/model/location.dart';
import 'package:equatable/equatable.dart';
import 'package:flag_point_repository_local_storage/flag_point_repository_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

part 'pin_location_state.dart';

class PinLocationCubit extends Cubit<PinLocationState> {
  PinLocationCubit(this.localStorageRepository)
      : super(const PinLocationInitial());

  final LocalStorageRepository<Location> localStorageRepository;

  factory PinLocationCubit.create(BuildContext context) =>
      PinLocationCubit(context.read<LocalStorageRepository<Location>>());

  void onSetPinLocation(LatLng latLng) async {
    try {
      emit(const PinLocationLoading());
      final location = Location(latLng.longitude, latLng.latitude);
      await localStorageRepository.add(location);
      emit(const PinLocationSave());
    } catch (e) {
      emit(const PinLocationError('Can"t save pin location'));
    }
  }
}
