import 'package:my_weather_app/src/core/runner/failure.dart';
import 'package:my_weather_app/src/core/runner/service_runner.dart';
import 'package:my_weather_app/src/features/weather/data/datasource/weather_datasource.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_request_dto.dart';
import 'package:my_weather_app/src/features/weather/domain/entities/weather_entity.dart';
import 'package:my_weather_app/src/features/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDatasource datasource;

  WeatherRepositoryImpl({required this.datasource});
  final String name = '$WeatherRepositoryImpl';
  @override
  FutureEither<WeatherEntity> getCurrentWeather({required GetWeatherRequestDto requestDto}) async {
    return ServiceRunner<Failure, WeatherEntity>().run(
        call: datasource.getCurrentWeather(requestDto: requestDto).then(
              (weatherResponseDto) => WeatherEntity.fromResponseDto(weatherResponseDto),
            ),
        name: name);
  }
}
