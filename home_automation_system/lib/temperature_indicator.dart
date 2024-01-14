import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class TemperatureIndicator extends StatelessWidget {
  final double maxValue;
  final double value;

  TemperatureIndicator({
    required this.maxValue,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the percentage of the current value relative to the maximum value.
    final double percentage = value / maxValue;

    return Center(
      child: LiquidLinearProgressIndicator(
        value: percentage, // Set the animation value.
        valueColor: AlwaysStoppedAnimation(
            Colors.white10), // Use the accent color from the theme.
        // Color of the border.
        borderWidth: 2.0, // Width of the border.
        borderRadius: 12.0, // Border radius of the indicator.
        direction: Axis.horizontal, // Direction of the animation.
        center: Text(
          '${value.toStringAsFixed(1)}°C', // Display the current temperature.
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
