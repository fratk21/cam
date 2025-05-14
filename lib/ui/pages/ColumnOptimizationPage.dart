import 'package:flutter/material.dart';
import 'dart:math' as Math;

class ColumnOptimizationPage extends StatefulWidget {
  @override
  _ColumnOptimizationPageState createState() => _ColumnOptimizationPageState();
}

class _ColumnOptimizationPageState extends State<ColumnOptimizationPage> {
  final loadController = TextEditingController();
  final concreteStrengthController = TextEditingController();
  String result = "";

  void calculate() {
    double load = double.tryParse(loadController.text) ?? 0;
    double strength = double.tryParse(concreteStrengthController.text) ?? 0;

    if (load <= 0 || strength <= 0) {
      setState(() {
        result = "❗ Lütfen yük ve beton dayanımı değerlerini doğru giriniz.";
      });
      return;
    }

    double areaCm2 = (load * 1000) / (0.5 * strength * 1e1);
    double side = Math.sqrt(areaCm2);

    setState(() {
      result = "💡 Önerilen Kolon Boyu: ${side.toStringAsFixed(1)} cm";
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
      appBar: AppBar(title: Text("Kolon Boyut Önerisi")),
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
                    buildInput(
                        loadController, "Yük (kN)", Icons.fitness_center),
                    buildInput(concreteStrengthController,
                        "Beton Dayanımı (MPa)", Icons.shield),
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
