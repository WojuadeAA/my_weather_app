part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;
  const WeatherLoaded({
    required this.weather,
  });
  @override
  List<Object> get props => [weather];
}

final class WeatherFailure extends WeatherState {
  final Failure failure;
  const WeatherFailure({
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}
