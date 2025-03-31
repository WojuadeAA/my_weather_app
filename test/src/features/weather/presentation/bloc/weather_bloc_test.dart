import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_weather_app/src/core/runner/failure.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_request_dto.dart';
import 'package:my_weather_app/src/features/weather/domain/entities/weather_entity.dart';
import 'package:my_weather_app/src/features/weather/domain/usecases/get_weather_usecase.dart';
import 'package:my_weather_app/src/features/weather/presentation/bloc/weather_bloc.dart';

class MockGetWeatherUseCase extends Mock implements GetWeatherUseCase {}

void main() {
  late MockGetWeatherUseCase mockGetWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetWeatherUseCase = MockGetWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetWeatherUseCase);
  });

  const mockRequestDto = GetWeatherRequestDto(
    latitude: "37.7749",
    longitude: "-122.4194",
  );
  const mockWeatherEntity = WeatherEntity(
    cityName: "London",
    iconCode: "03d",
    iconUrl: "iconUrl",
    tempCelsius: "33",
    tempFahrenheit: "33",
  );
  const mockCommonFailure = CommonFailure("title", "message");
  group('weather bloc tests ...', () {
    test("should get loading state", () {
      expect(weatherBloc.state, WeatherLoading());
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when FetchWeatherEvent is added.',
      build: () {
        when(() => mockGetWeatherUseCase.call(params: mockRequestDto))
            .thenAnswer((_) async => const Right(mockWeatherEntity));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeatherEvent(lat: mockRequestDto.latitude, lon: mockRequestDto.longitude)),
      expect: () => <WeatherState>[WeatherLoading(), const WeatherLoaded(weather: mockWeatherEntity)],
    );
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when RefreshWeatherEvent is added.',
      build: () {
        when(() => mockGetWeatherUseCase.call(params: mockRequestDto))
            .thenAnswer((_) async => const Right(mockWeatherEntity));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(RefreshWeatherEvent(lat: mockRequestDto.latitude, lon: mockRequestDto.longitude)),
      expect: () => <WeatherState>[WeatherLoading(), const WeatherLoaded(weather: mockWeatherEntity)],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherFailure] when RefreshWeatherEvent is added.',
      build: () {
        when(() => mockGetWeatherUseCase.call(params: mockRequestDto))
            .thenAnswer((_) async => const Left(mockCommonFailure));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(RefreshWeatherEvent(lat: mockRequestDto.latitude, lon: mockRequestDto.longitude)),
      expect: () => <WeatherState>[WeatherLoading(), const WeatherFailure(failure: mockCommonFailure)],
    );
  });
}
