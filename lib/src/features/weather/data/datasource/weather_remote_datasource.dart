import 'package:my_weather_app/src/core/constants/endpoints.dart';
import 'package:my_weather_app/src/core/network/network_service.dart';
import 'package:my_weather_app/src/core/network/response_processor.dart';
import 'package:my_weather_app/src/features/weather/data/datasource/weather_datasource.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_request_dto.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_response_dto.dart';

class WeatherRemoteDatasource implements WeatherDatasource {
  final HttpService httpService;

  WeatherRemoteDatasource({required this.httpService});
  @override
  Future<WeatherResponseDto> getCurrentWeather({required GetWeatherRequestDto requestDto}) async {
    final response =
        await httpService.get(Endpoints.getWeather, queryParameters: requestDto.withApiKey().toQueryParam());
    return processResponse(
      response: response,
      serializer: (data) {
        return WeatherResponseDto.fromJson(data);
      },
    );
  }
}
