import 'package:flutter/material.dart';

class SlopeStabilityPage extends StatefulWidget {
  @override
  _SlopeStabilityPageState createState() => _SlopeStabilityPageState();
}

class _SlopeStabilityPageState extends State<SlopeStabilityPage> {
  final slopeAngleController = TextEditingController();
  final slopeHeightController = TextEditingController();
  String result = "";

  void calculate() {
    double slopeAngle = double.tryParse(slopeAngleController.text) ?? 0;
    double slopeHeight = double.tryParse(slopeHeightController.text) ?? 0;

    if (slopeAngle <= 0 || slopeHeight <= 0) {
      setState(() {
        result =
            "❗ Lütfen şev açısı ve yüksekliği doğru ve sıfırdan büyük giriniz.";
      });
      return;
    }

    double safetyFactor = (45 - slopeAngle) / slopeHeight;

    setState(() {
      result =
          "💡 Basit Stabilite Faktörü: ${safetyFactor.toStringAsFixed(2)}\n📋 Saha kontrolü için öneri.";
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
      appBar: AppBar(title: Text("Şev Stabilite Faktörü")),
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
                    buildInput(slopeAngleController, "Şev Açısı (°)",
                        Icons.stacked_line_chart),
                    buildInput(slopeHeightController, "Şev Yüksekliği (m)",
                        Icons.height),
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
