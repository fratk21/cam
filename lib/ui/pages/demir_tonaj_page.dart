import 'package:flutter/material.dart';
import 'package:cam/services/statik_service.dart';

class DemirTonajPage extends StatefulWidget {
  @override
  _DemirTonajPageState createState() => _DemirTonajPageState();
}

class _DemirTonajPageState extends State<DemirTonajPage> {
  final areaController = TextEditingController();
  final lengthController = TextEditingController();
  String result = "";

  void calculate() {
    double area = double.tryParse(areaController.text) ?? 0;
    double length = double.tryParse(lengthController.text) ?? 0;

    if (area <= 0 || length <= 0) {
      setState(() {
        result = "❗ Lütfen kesit alanı ve uzunluk değerlerini doğru giriniz.";
      });
      return;
    }

    double tonnage = StatikService.calculateRebarTonnage(area, length);

    setState(() {
      result = "💡 Demir Tonajı: ${tonnage.toStringAsFixed(3)} ton";
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
      appBar: AppBar(title: Text("Demir Tonaj Hesabı")),
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
                        areaController, "Kesit Alanı (mm²)", Icons.grid_on),
                    buildInput(
                        lengthController, "Uzunluk (m)", Icons.straighten),
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
