import 'package:flutter/material.dart';
import 'dart:math' as Math;

class SlopedRoofAreaPage extends StatefulWidget {
  @override
  _SlopedRoofAreaPageState createState() => _SlopedRoofAreaPageState();
}

class _SlopedRoofAreaPageState extends State<SlopedRoofAreaPage> {
  final baseAreaController = TextEditingController();
  final slopeController = TextEditingController();
  String result = "";

  void calculate() {
    double baseArea = double.tryParse(baseAreaController.text) ?? 0;
    double slopeDeg = double.tryParse(slopeController.text) ?? 0;

    if (baseArea <= 0 || slopeDeg <= 0) {
      setState(() {
        result =
            "❗ Lütfen taban alanı ve eğim açısını doğru ve sıfırdan büyük giriniz.";
      });
      return;
    }

    double slopeRad = slopeDeg * Math.pi / 180;
    double realArea = baseArea / Math.cos(slopeRad);

    setState(() {
      result = "💡 Çatı Alanı (eğimli): ${realArea.toStringAsFixed(2)} m²";
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
      appBar: AppBar(title: Text("Eğimli Çatı Alanı Hesabı")),
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
                    buildInput(baseAreaController, "Taban Alanı (m²)",
                        Icons.crop_square),
                    buildInput(
                        slopeController, "Eğim Açısı (°)", Icons.terrain),
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
