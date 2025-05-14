import 'package:flutter/material.dart';
import 'package:light/light.dart';

class LightMeterPage extends StatefulWidget {
  @override
  _LightMeterPageState createState() => _LightMeterPageState();
}

class _LightMeterPageState extends State<LightMeterPage> {
  Light? _light;
  double lux = 0;

  @override
  void initState() {
    super.initState();
    _light = Light();
    _light!.lightSensorStream.listen((event) {
      if (!mounted) return;
      setState(() {
        lux = double.tryParse(event.toString()) ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Işık Ölçer (Lux Metre)")),
      body: Center(
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(24),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.light_mode, size: 60, color: Colors.amber),
                SizedBox(height: 20),
                Text("Işık Şiddeti", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text(
                  "${lux.toStringAsFixed(1)} Lux",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
