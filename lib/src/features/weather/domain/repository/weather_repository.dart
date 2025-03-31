import 'package:my_weather_app/src/core/runner/service_runner.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_request_dto.dart';
import 'package:my_weather_app/src/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  FutureEither<WeatherEntity> getCurrentWeather({required GetWeatherRequestDto requestDto});
}
