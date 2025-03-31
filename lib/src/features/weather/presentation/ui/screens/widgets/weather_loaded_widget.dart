import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:my_weather_app/src/features/weather/domain/entities/weather_entity.dart';
import 'package:my_weather_app/src/features/weather/presentation/cubit/temperature_unit_cubit.dart';

class WeatherLoadedWidget extends StatelessWidget {
  const WeatherLoadedWidget({
    super.key,
    required this.weather,
  });
  final WeatherEntity weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: AspectRatio(
            aspectRatio: MediaQuery.sizeOf(context).width < 300 ? 4 / 3 : 16 / 9,
            child: CachedNetworkImage(
              imageUrl: weather.iconUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              alignment: Alignment.center,
              fadeInDuration: const Duration(milliseconds: 500),
              fadeOutDuration: const Duration(milliseconds: 500),
              fadeInCurve: Curves.easeIn,
              fadeOutCurve: Curves.easeOut,
            ),
          ),
        ),
        const Gap(32),
        Align(
          alignment: Alignment.center,
          child: Text(
            "THIS IS MY WEATHER APP",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const Gap(24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Temprature",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            BlocBuilder<TemperatureUnitCubit, TemperatureUnitState>(
              builder: (context, state) {
                return switch (state) {
                  CelsiusTemperatureUnit() => Text(
                      "${weather.tempCelsius} degrees",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  FahrenheitTemperatureUnit() => Text(
                      "${weather.tempFahrenheit} degrees",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                };
              },
            ),
            const Gap(8),
            Text(
              "Location",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              weather.cityName,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const Gap(32),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Celsius/Fahrenheit",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Gap(8),
            // Temperature Unit Switch
            BlocBuilder<TemperatureUnitCubit, TemperatureUnitState>(
              builder: (context, state) {
                return Switch.adaptive(
                    value: state is FahrenheitTemperatureUnit,
                    onChanged: (value) {
                      if (value) {
                        context.read<TemperatureUnitCubit>().setFahrenheit();
                      } else {
                        context.read<TemperatureUnitCubit>().setCelsius();
                      }
                    });
              },
            )
          ],
        ),
      ],
    );
  }
}
