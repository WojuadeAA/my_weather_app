part of 'temperature_unit_cubit.dart';

sealed class TemperatureUnitState extends Equatable {
  const TemperatureUnitState();

  @override
  List<Object> get props => [];
}

final class CelsiusTemperatureUnit extends TemperatureUnitState {}

final class FahrenheitTemperatureUnit extends TemperatureUnitState {}
