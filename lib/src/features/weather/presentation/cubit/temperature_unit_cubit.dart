import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'temperature_unit_state.dart';

class TemperatureUnitCubit extends Cubit<TemperatureUnitState> {
  TemperatureUnitCubit() : super(CelsiusTemperatureUnit());

  void setCelsius() {
    emit(CelsiusTemperatureUnit());
  }

  void setFahrenheit() {
    emit(FahrenheitTemperatureUnit());
  }
}
