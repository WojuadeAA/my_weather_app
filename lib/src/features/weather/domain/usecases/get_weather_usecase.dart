import 'package:my_weather_app/src/core/runner/service_runner.dart';
import 'package:my_weather_app/src/core/usecase/usecase.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_request_dto.dart';
import 'package:my_weather_app/src/features/weather/domain/entities/weather_entity.dart';

import '../repository/weather_repository.dart';

class GetWeatherUseCase implements UseCase<FutureEither<WeatherEntity>, GetWeatherRequestDto> {
  final WeatherRepository weatherRepository;

  GetWeatherUseCase({required this.weatherRepository});

  @override
  FutureEither<WeatherEntity> call({GetWeatherRequestDto? params}) {
    return weatherRepository.getCurrentWeather(requestDto: params!);
  }
}
