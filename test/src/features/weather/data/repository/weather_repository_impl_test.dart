import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_weather_app/src/features/weather/data/datasource/weather_remote_datasource.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_request_dto.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_response_dto.dart';
import 'package:my_weather_app/src/features/weather/data/repository/weather_repository_impl.dart';
import 'package:my_weather_app/src/features/weather/domain/entities/weather_entity.dart';

import '../../../../../test_constants.dart';

class MockRemoteWeatherDataSource extends Mock implements WeatherRemoteDatasource {}

void main() {
  late MockRemoteWeatherDataSource mockRemoteWeatherDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;
  setUp(() {
    mockRemoteWeatherDataSource = MockRemoteWeatherDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(datasource: mockRemoteWeatherDataSource);
  });
  group('weather repository impl ...', () {
    test("getCurrentWeather should return WeatherEntity", () async {
      const mockRequestDto = GetWeatherRequestDto(
        latitude: "37.7749",
        longitude: "-122.4194",
      );
      final mockResponse = WeatherResponseDto.fromJson(getWeatherMockJson);
      // Arrange
      when(() => mockRemoteWeatherDataSource.getCurrentWeather(requestDto: mockRequestDto))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await weatherRepositoryImpl.getCurrentWeather(requestDto: mockRequestDto);

      // Assert
      expect(result.isRight(), true);
      expect(result.isLeft(), false);
      expect(result.getRight().toNullable(), isA<WeatherEntity>());
      expect(result.getRight().toNullable(), WeatherEntity.fromResponseDto(mockResponse));
    });
  });
}
