import 'package:flutter/material.dart';
import 'package:cam/services/statik_service.dart';

class TemelBoyutPage extends StatefulWidget {
  @override
  _TemelBoyutPageState createState() => _TemelBoyutPageState();
}

class _TemelBoyutPageState extends State<TemelBoyutPage> {
  final loadController = TextEditingController();
  final soilController = TextEditingController();
  String result = "";

  void calculate() {
    double load = double.tryParse(loadController.text) ?? 0;
    double soil = double.tryParse(soilController.text) ?? 0;

    if (load <= 0 || soil <= 0) {
      setState(() {
        result =
            "❗ Lütfen yük ve zemin taşıma gücünü doğru ve sıfırdan büyük giriniz.";
      });
      return;
    }

    double width = StatikService.calculateSquareFoundationSize(load, soil);
    setState(() {
      result = "💡 Gerekli Temel Kenar Boyu: ${width.toStringAsFixed(2)} m";
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
      appBar: AppBar(title: Text("Temel Boyutlandırma (Kare Temel)")),
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
                    buildInput(loadController, "Yük (kN)",
                        Icons.vertical_align_bottom),
                    buildInput(soilController, "Zemin Taşıma Gücü (kN/m²)",
                        Icons.terrain),
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
