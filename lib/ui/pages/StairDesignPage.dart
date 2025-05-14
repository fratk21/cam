import 'package:flutter/material.dart';

class StairDesignPage extends StatefulWidget {
  @override
  _StairDesignPageState createState() => _StairDesignPageState();
}

class _StairDesignPageState extends State<StairDesignPage> {
  final heightController = TextEditingController();
  final runController = TextEditingController();
  String result = "";

  void calculate() {
    double height = double.tryParse(heightController.text) ?? 0;
    double run = double.tryParse(runController.text) ?? 0;

    if (height <= 0 || run <= 0) {
      setState(() {
        result =
            "❗ Lütfen toplam yükseklik ve genişliği doğru ve sıfırdan büyük giriniz.";
      });
      return;
    }

    int steps = (height / 0.17).ceil();
    double stepRise = height / steps;
    double stepRun = run / steps;

    setState(() {
      result =
          "💡 Basamak Sayısı: $steps\n↕ Yükselti: ${stepRise.toStringAsFixed(2)} m\n↔ Genişlik: ${stepRun.toStringAsFixed(2)} m";
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
      appBar: AppBar(title: Text("Merdiven Basamak Hesabı")),
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
                        heightController, "Toplam Yükseklik (m)", Icons.height),
                    buildInput(
                        runController, "Toplam Genişlik (m)", Icons.straighten),
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
