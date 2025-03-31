import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_weather_app/src/core/theme/app_theme.dart';
import 'package:my_weather_app/src/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:my_weather_app/src/features/weather/presentation/cubit/temperature_unit_cubit.dart';
import 'package:my_weather_app/src/features/weather/presentation/ui/screens/home_screen.dart';
import 'package:my_weather_app/src/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooper Weather App',
      theme: appTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<WeatherBloc>()..add(const FetchWeatherEvent())),
          BlocProvider(create: (context) => getIt<TemperatureUnitCubit>()),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
