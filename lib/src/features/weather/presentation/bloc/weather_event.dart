part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class FetchWeatherEvent extends WeatherEvent {
  final String lat;
  final String lon;
  const FetchWeatherEvent({
    this.lat = "51.51494225418024",
    this.lon = "-0.12363193061883422",
  });
  @override
  List<Object> get props => [lat, lon];
}

final class RefreshWeatherEvent extends WeatherEvent {
  final String lat;
  final String lon;
  const RefreshWeatherEvent({
    this.lat = "51.51494225418024",
    this.lon = "-0.12363193061883422",
  });
  @override
  List<Object> get props => [lat, lon];
}
