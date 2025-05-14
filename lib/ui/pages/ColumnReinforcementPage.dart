import 'package:flutter/material.dart';
import 'dart:math' as Math;

class ColumnReinforcementPage extends StatefulWidget {
  @override
  _ColumnReinforcementPageState createState() =>
      _ColumnReinforcementPageState();
}

class _ColumnReinforcementPageState extends State<ColumnReinforcementPage> {
  final loadController = TextEditingController();
  final fydController = TextEditingController();
  String result = "";

  void calculate() {
    double load = double.tryParse(loadController.text) ?? 0;
    double fyd = double.tryParse(fydController.text) ?? 0;

    if (load <= 0 || fyd <= 0) {
      setState(() {
        result = "❗ Lütfen yük ve beton dayanımını doğru giriniz.";
      });
      return;
    }

    double areaCm2 = (load * 1000) / (0.5 * fyd * 1e1);
    double sideCm = Math.sqrt(areaCm2);
    double requiredAs = load * 1000 / (0.9 * 500); // N/mm²
    int barCount = (requiredAs / (Math.pi * Math.pow(16 / 2, 2))).ceil();

    setState(() {
      result =
          "💡 Kolon Boyutu: ${sideCm.toStringAsFixed(1)} cm\n💡 Donatı Önerisi: ${barCount} adet Ø16";
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
      appBar: AppBar(title: Text("Kolon Boyut + Donatı Önerisi")),
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
                    buildInput(
                        fydController, "Beton Dayanımı (MPa)", Icons.shield),
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
