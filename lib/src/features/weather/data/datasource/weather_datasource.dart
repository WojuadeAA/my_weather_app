import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_request_dto.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_response_dto.dart';

abstract class WeatherDatasource {
  Future<WeatherResponseDto> getCurrentWeather({required GetWeatherRequestDto requestDto});
}
