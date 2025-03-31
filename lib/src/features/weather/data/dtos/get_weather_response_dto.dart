import 'package:equatable/equatable.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/temperature_data.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/weather_data.dart';

/// This file contains the Data Transfer Object (DTO) for the weather response.
/// It is responsible for converting the entire weather API response into a Dart model.
/// The DTO acts as an intermediary between the raw JSON data from the API and the
/// application's domain models, ensuring type safety and structured data handling.
class WeatherResponseDto extends Equatable {
  const WeatherResponseDto({
    required this.weather,
    required this.main,
    required this.name,
  });

  final List<WeatherData> weather;

  final TemperatureData? main;

  final String name;

  factory WeatherResponseDto.fromJson(Map<String, dynamic> json) {
    return WeatherResponseDto(
      weather:
          json["weather"] == null ? [] : List<WeatherData>.from(json["weather"]!.map((x) => WeatherData.fromJson(x))),
      main: json["main"] == null ? null : TemperatureData.fromJson(json["main"]),
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "weather": weather.map((x) => x.toJson()).toList(),
        "main": main?.toJson(),
        "name": name,
      };

  @override
  List<Object?> get props => [weather, main, name];
}
