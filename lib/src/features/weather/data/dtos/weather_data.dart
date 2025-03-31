import 'package:equatable/equatable.dart';

/// Represents the Weather data within the weather response DTO.
class WeatherData extends Equatable {
  const WeatherData({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherData copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) {
    return WeatherData(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      id: json["id"] ?? 0,
      main: json["main"] ?? "",
      description: json["description"] ?? "",
      icon: json["icon"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };

  @override
  String toString() {
    return "$id, $main, $description, $icon, ";
  }

  @override
  List<Object?> get props => [id, main, description, icon];
}
