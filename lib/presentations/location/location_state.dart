part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {
  const LocationInitial();

  @override
  List<Object?> get props => [];
}

class LocationLoading extends LocationState {
  const LocationLoading();

  @override
  List<Object?> get props => [];
}

class LocationSuccess extends LocationState {
  const LocationSuccess();

  @override
  List<Object?> get props => [];
}

class LocationPosition extends LocationState {
  final Location location;

  const LocationPosition(this.location);

  @override
  List<Object?> get props => [];
}

class LocationPermissionDenied extends LocationState {
  const LocationPermissionDenied();

  @override
  List<Object?> get props => [];
}

class LocationError extends LocationState {
  final String message;

  const LocationError(this.message);

  @override
  List<Object?> get props => [message];
}
