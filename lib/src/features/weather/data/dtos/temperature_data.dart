import 'package:equatable/equatable.dart';

/// Represents the Main TemperatureData data within the weather response DTO.
class TemperatureData extends Equatable {
  const TemperatureData({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  final num temp;
  final num feelsLike;
  final num tempMin;
  final num tempMax;
  final num pressure;
  final int humidity;
  final num seaLevel;
  final num grndLevel;

  TemperatureData copyWith({
    num? temp,
    num? feelsLike,
    num? tempMin,
    num? tempMax,
    num? pressure,
    int? humidity,
    num? seaLevel,
    num? grndLevel,
  }) {
    return TemperatureData(
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      seaLevel: seaLevel ?? this.seaLevel,
      grndLevel: grndLevel ?? this.grndLevel,
    );
  }

  factory TemperatureData.fromJson(Map<String, dynamic> json) {
    return TemperatureData(
      temp: json["temp"] ?? 0,
      feelsLike: json["feels_like"] ?? 0,
      tempMin: json["temp_min"] ?? 0,
      tempMax: json["temp_max"] ?? 0,
      pressure: json["pressure"] ?? 0,
      humidity: json["humidity"] ?? 0,
      seaLevel: json["sea_level"] ?? 0,
      grndLevel: json["grnd_level"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
      };

  @override
  String toString() {
    return "$temp, $feelsLike, $tempMin, $tempMax, $pressure, $humidity, $seaLevel, $grndLevel, ";
  }

  @override
  List<Object?> get props => [temp, feelsLike, tempMin, tempMax, pressure, humidity, seaLevel, grndLevel];
}
