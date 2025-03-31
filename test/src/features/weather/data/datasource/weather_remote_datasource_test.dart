// import 'package:coopah_onboarding/core/constants/constants.dart';
// import 'package:coopah_onboarding/core/errors/errors.dart';
// import 'package:coopah_onboarding/features/weather/data/data_source/remote_data_source.dart';
// import 'package:coopah_onboarding/features/weather/data/models/weather.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;

// import '../../../../helpers/json_from_file.dart';
// import '../../../../helpers/test_helper.mocks.dart';

// void main() {
//   late MockHttpClient mockHttpClient;
//   late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;
//   const testDataPath = "test/helpers/test_data/test_weather_data.json";
//   const String testLat = "51.51494225418024", testLng = "-0.12363193061883422";
//   const TempUnit unit = TempUnit.metric;
//   setUp(() {
//     mockHttpClient = MockHttpClient();
//     weatherRemoteDataSourceImpl =
//         WeatherRemoteDataSourceImpl(client: mockHttpClient);
//   });
//   group("get current weather", () {
//     test("should return weather model when status code is 200", () async {
//       when(
//         mockHttpClient.get(
//           Uri.parse(
//             Urls.currentWeatherByGeoLocation(testLat, testLng, unit),
//           ),
//         ),
//       ).thenAnswer((_) async => http.Response(loadJson(testDataPath), 200));
//       final result = await weatherRemoteDataSourceImpl.getCurrentWeather(
//           testLat, testLng, unit);

//       expect(result, isA<WeatherModel>());
//     });

//     test("should throw server exception when server return other than 200   ",
//         () async {
//       when(
//         mockHttpClient.get(
//           Uri.parse(
//             Urls.currentWeatherByGeoLocation(testLat, testLng, unit),
//           ),
//         ),
//       ).thenAnswer(
//         (_) async => http.Response("Data Not Found", 404),
//       );
//       final result = weatherRemoteDataSourceImpl.getCurrentWeather(
//           testLat, "$testLng k", unit);

//       expect(result, throwsA(isA<ServerException>()));
//     });
//   });
// }

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_weather_app/src/core/constants/endpoints.dart';
import 'package:my_weather_app/src/core/network/network_service.dart';
import 'package:my_weather_app/src/features/weather/data/datasource/weather_remote_datasource.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_request_dto.dart';
import 'package:my_weather_app/src/features/weather/data/dtos/get_weather_response_dto.dart';

import '../../../../../test_constants.dart';

// Mocking HttpService class
class MockHttpService extends Mock implements HttpService {}

void main() {
  late WeatherRemoteDatasource remoteDatasource;
  late MockHttpService httpService;
  setUp(() {
    httpService = MockHttpService();
    remoteDatasource = WeatherRemoteDatasource(httpService: httpService);
  });

  group('weather remote datasource ...', () {
    test("test getCurrentWeather returns WeatherResponseDto", () async {
      const mockRequestDto = GetWeatherRequestDto(latitude: "latitude", longitude: "", apiKey: "apiKey");
      final mockResponse = Response(
        requestOptions: RequestOptions(path: Endpoints.getWeather, queryParameters: mockRequestDto.toQueryParam()),
        statusCode: 200,
        data: getWeatherMockJson,
      );
      when(
        () => httpService.get(
          Endpoints.getWeather,
          queryParameters: mockRequestDto.toQueryParam(),
        ),
      ).thenAnswer((_) async => Future.value(mockResponse));
      final result = await remoteDatasource.getCurrentWeather(requestDto: mockRequestDto);
      expect(result, WeatherResponseDto.fromJson(getWeatherMockJson));
      verify(
        () => httpService.get(Endpoints.getWeather, queryParameters: mockRequestDto.toQueryParam()),
      ).called(1);
    });

    test("test getCurrentWeather throws an exception on non-200 response", () async {
      const mockRequestDto = GetWeatherRequestDto(latitude: "latitude", longitude: "", apiKey: "apiKey");
      final mockResponse = Response(
        requestOptions: RequestOptions(path: Endpoints.getWeather, queryParameters: mockRequestDto.toQueryParam()),
        statusCode: 404,
        data: {"message": "Not Found"},
      );
      when(
        () => httpService.get(
          Endpoints.getWeather,
          queryParameters: mockRequestDto.toQueryParam(),
        ),
      ).thenAnswer((_) async => Future.value(mockResponse));
      expect(
        () async => await remoteDatasource.getCurrentWeather(requestDto: mockRequestDto),
        throwsException,
      );
      verify(
        () => httpService.get(Endpoints.getWeather, queryParameters: mockRequestDto.toQueryParam()),
      ).called(1);
    });
  });
}
