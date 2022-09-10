part of 'pin_location_cubit.dart';

abstract class PinLocationState extends Equatable {
  const PinLocationState();

  @override
  List<Object?> get props => [];
}

class PinLocationInitial extends PinLocationState {
  const PinLocationInitial();

  @override
  List<Object?> get props => [];
}

class PinLocationLoading extends PinLocationState {
  const PinLocationLoading();

  @override
  List<Object?> get props => [];
}

class PinLocationSave extends PinLocationState {
  const PinLocationSave();

  @override
  List<Object?> get props => [];
}


class PinLocationError extends PinLocationState {
  final String message;
  const PinLocationError(this.message);
  @override
  List<Object?> get props => [];
}