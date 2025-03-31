import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:my_weather_app/src/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:my_weather_app/src/features/weather/presentation/ui/screens/widgets/weather_error_widget.dart';

import 'widgets/weather_loaded_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
          // Listen to the changes on temp unit cubit to update the weather fetching unit
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return Column(
                children: [
                  switch (state) {
                    WeatherLoading() => const Expanded(
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    WeatherFailure() => WeatherErrorWidget(errorMessage: state.failure.message),
                    WeatherLoaded() => WeatherLoadedWidget(weather: state.weather),
                  },
                  if (state is WeatherLoaded || state is WeatherFailure) const Spacer(),
                  // Refresh Button
                  if (state is WeatherLoaded || state is WeatherFailure)
                    ElevatedButton(
                      onPressed: () {
                        // Fire Refresh event to refech data
                        context.read<WeatherBloc>().add(const RefreshWeatherEvent());
                      },
                      child: const Text("Refresh"),
                    ),
                  const Gap(32),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
