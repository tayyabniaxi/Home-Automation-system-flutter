import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_node_auth/services/ESP_services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Temppage extends StatefulWidget {
  @override
  _TemppageState createState() => _TemppageState();
}

class _TemppageState extends State<Temppage> {
  String temp = '0';

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      fetchTemperature();
    });
  }

  fetchTemperature() async {
    await ESPServices().fetchTemperature().then((value) {
      setState(() {
        temp = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Speech to Text'),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Temp is: ${temp} C",
                style: const TextStyle(fontSize: 30),
              ),
              // Example 16
              SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: 30, color: Colors.green),
                  GaugeRange(
                      startValue: 30, endValue: 50, color: Colors.orange),
                  GaugeRange(startValue: 50, endValue: 100, color: Colors.red)
                ], pointers: <GaugePointer>[
                  NeedlePointer(value: double.parse(temp))
                ], annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Container(
                          child: Text(temp,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold))),
                      angle: 90,
                      positionFactor: 0.5)
                ])
              ])
            ],
          ),
        ),
      ),
    );
  }
}
