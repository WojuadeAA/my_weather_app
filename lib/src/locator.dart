import 'package:get_it/get_it.dart';
import 'package:my_weather_app/src/core/constants/endpoints.dart';
import 'package:my_weather_app/src/core/network/network_service.dart';
import 'package:my_weather_app/src/features/weather/data/datasource/weather_remote_datasource.dart';
import 'package:my_weather_app/src/features/weather/data/repository/weather_repository_impl.dart';
import 'package:my_weather_app/src/features/weather/domain/usecases/get_weather_usecase.dart';
import 'package:my_weather_app/src/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:my_weather_app/src/features/weather/presentation/cubit/temperature_unit_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => IHttpService(baseUrl: Endpoints.baseUrl));

  getIt.registerLazySingleton(() => WeatherRemoteDatasource(httpService: getIt<IHttpService>()));
  getIt.registerLazySingleton(() => WeatherRepositoryImpl(datasource: getIt<WeatherRemoteDatasource>()));
  getIt.registerLazySingleton(() => GetWeatherUseCase(weatherRepository: getIt<WeatherRepositoryImpl>()));
  getIt.registerFactory(() => WeatherBloc(getIt<GetWeatherUseCase>()));
  getIt.registerFactory(() => TemperatureUnitCubit());
}
