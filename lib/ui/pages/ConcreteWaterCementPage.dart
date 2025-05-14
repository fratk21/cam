import 'package:flutter/material.dart';

class ConcreteWaterCementPage extends StatefulWidget {
  @override
  _ConcreteWaterCementPageState createState() =>
      _ConcreteWaterCementPageState();
}

class _ConcreteWaterCementPageState extends State<ConcreteWaterCementPage> {
  final volumeController = TextEditingController();
  String result = "";

  void calculate() {
    double volume = double.tryParse(volumeController.text) ?? 0;

    if (volume <= 0) {
      setState(() {
        result = "❗ Lütfen beton hacmini doğru giriniz.";
      });
      return;
    }

    double cementKg = 320 * volume;
    double waterKg = 160 * volume;
    double wcratio = waterKg / cementKg;

    setState(() {
      result =
          "💡 Çimento: ${cementKg.toStringAsFixed(1)} kg\n💡 Su: ${waterKg.toStringAsFixed(1)} kg\n💡 Su/Çimento Oranı: ${wcratio.toStringAsFixed(2)}";
    });
  }

  Widget buildInput(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Beton Karışımı + Su/Çimento Oranı")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildInput(volumeController, "Beton Hacmi (m³)",
                        Icons.cloud_queue),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: Icon(Icons.calculate),
                      label: Text("Hesapla"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50)),
                      onPressed: calculate,
                    ),
                  ],
                ),
              ),
            ),
            if (result.isNotEmpty)
              Card(
                elevation: 3,
                color: Colors.blueGrey[50],
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
