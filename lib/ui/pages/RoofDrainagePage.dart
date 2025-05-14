import 'package:flutter/material.dart';

class RoofDrainagePage extends StatefulWidget {
  @override
  _RoofDrainagePageState createState() => _RoofDrainagePageState();
}

class _RoofDrainagePageState extends State<RoofDrainagePage> {
  final areaController = TextEditingController();
  final rainfallController = TextEditingController();
  String result = "";

  void calculate() {
    double area = double.tryParse(areaController.text) ?? 0;
    double rainfall = double.tryParse(rainfallController.text) ?? 0;

    if (area <= 0 || rainfall <= 0) {
      setState(() {
        result = "❗ Lütfen çatı alanı ve yağış yoğunluğunu doğru giriniz.";
      });
      return;
    }

    double flowLps = (area * rainfall) / 3600;

    setState(() {
      result =
          "💧 Gerekli Su Debisi: ${flowLps.toStringAsFixed(2)} L/s\n📏 Önerilen Boru Çapı: ≥ Ø100 mm";
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
      appBar: AppBar(title: Text("Çatı Drenaj Hesabı")),
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
                        areaController, "Çatı Alanı (m²)", Icons.home_work),
                    buildInput(rainfallController,
                        "Yağış Yoğunluğu (L/m²/saat)", Icons.cloud),
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
