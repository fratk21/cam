import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:math' as Math;

class LevelMeterPage extends StatefulWidget {
  @override
  _LevelMeterPageState createState() => _LevelMeterPageState();
}

class _LevelMeterPageState extends State<LevelMeterPage> {
  double pitch = 0;
  double roll = 0;
  StreamSubscription<AccelerometerEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = accelerometerEvents.listen((event) {
      double x = event.x;
      double y = event.y;
      double z = event.z;
      if (!mounted) return;
      setState(() {
        pitch = Math.atan2(-x, Math.sqrt(y * y + z * z)) * (180 / Math.pi);
        roll = Math.atan2(y, z) * (180 / Math.pi);
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Düzlük Ölçer (Su Terazisi)")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(Icons.device_thermostat, size: 50),
                    SizedBox(height: 20),
                    Text("Yatay Eğim (Pitch)", style: TextStyle(fontSize: 20)),
                    Text(
                      "${pitch.toStringAsFixed(1)}°",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(Icons.device_hub, size: 50),
                    SizedBox(height: 20),
                    Text("Dikey Eğim (Roll)", style: TextStyle(fontSize: 20)),
                    Text(
                      "${roll.toStringAsFixed(1)}°",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
