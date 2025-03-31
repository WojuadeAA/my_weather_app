import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WeatherErrorWidget extends StatelessWidget {
  const WeatherErrorWidget({super.key, required this.errorMessage});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(MediaQuery.sizeOf(context).height * 0.2),
          const Icon(
            Icons.error,
            size: 64,
            color: Colors.red,
          ),
          const Gap(16),
          Text(
            "Something went wrong",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Gap(16),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.normal),
          ),
          const Gap(24),
        ],
      ),
    );
  }
}
