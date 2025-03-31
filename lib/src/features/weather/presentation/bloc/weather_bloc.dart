import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather_app/src/core/runner/failure.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_request_dto.dart';
import 'package:my_weather_app/src/features/weather/domain/entities/weather_entity.dart';
import 'package:my_weather_app/src/features/weather/domain/usecases/get_weather_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  /// The initial state of the WeatherBloc is set to `WeatherLoading`
  /// to ensure that the weather data begins loading as soon as the screen is displayed.

  late final GetWeatherUseCase getCurrentWeatherUseCase;
  WeatherBloc(this.getCurrentWeatherUseCase) : super(WeatherLoading()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      final result = await getCurrentWeatherUseCase.call(
          params: GetWeatherRequestDto(
        latitude: event.lat,
        longitude: event.lon,
      ));
      result.fold(
        (failure) {
          emit(WeatherFailure(failure: failure));
        },
        (weatherEntity) {
          emit(WeatherLoaded(weather: weatherEntity));
        },
      );
    });
    on<RefreshWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      final result = await getCurrentWeatherUseCase.call(
          params: GetWeatherRequestDto(
        latitude: event.lat,
        longitude: event.lon,
      ));
      result.fold(
        (failure) {
          emit(WeatherFailure(failure: failure));
        },
        (weatherEntity) {
          emit(WeatherLoaded(weather: weatherEntity));
        },
      );
    });
  }
}
