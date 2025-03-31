import 'package:equatable/equatable.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_response_dto.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final String iconCode;
  final String iconUrl;
  final String tempFahrenheit;
  final String tempCelsius;

  const WeatherEntity({
    required this.cityName,
    required this.iconCode,
    required this.iconUrl,
    required this.tempFahrenheit,
    required this.tempCelsius,
  });

  factory WeatherEntity.fromResponseDto(WeatherResponseDto responseDto) {
    final tempKelvin = responseDto.main?.temp ?? 0;

    return WeatherEntity(
      cityName: responseDto.name,
      iconCode: responseDto.weather.first.icon,
      iconUrl: _buildIconUrl(responseDto.weather.first.icon),
      tempFahrenheit: _kelvinToFahrenheit(tempKelvin),
      tempCelsius: _kelvinToCelsius(tempKelvin),
    );
  }

  static String _buildIconUrl(String iconCode) => "https://openweathermap.org/img/wn/$iconCode@4x.png";

  static String _kelvinToFahrenheit(num kelvin) => ((kelvin - 273.15) * 9 / 5 + 32).toStringAsFixed(2);

  static String _kelvinToCelsius(num kelvin) => (kelvin - 273.15).toStringAsFixed(2);

  @override
  List<Object?> get props => [cityName, iconCode, iconUrl, tempFahrenheit, tempCelsius];
}
