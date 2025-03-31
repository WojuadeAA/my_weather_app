import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GetWeatherRequestDto extends Equatable {
  final String latitude;
  final String longitude;

  final String? apiKey;

  const GetWeatherRequestDto({required this.latitude, required this.longitude, this.apiKey});

  GetWeatherRequestDto withApiKey() {
    // this can be abstracted out to an interceptor if there are many other requests that require the api key to be used in this manner, for now Keep it simple
    return GetWeatherRequestDto(longitude: longitude, latitude: latitude, apiKey: dotenv.env['API_KEY']);
  }

  Map<String, String> toQueryParam() {
    return {
      "lat": latitude,
      "lon": longitude,
      if (apiKey != null) "appid": apiKey!,
    };
  }

  @override
  List<Object?> get props => [longitude, latitude];
}
