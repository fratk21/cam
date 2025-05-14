import 'package:flutter/material.dart';

class FormworkAreaPage extends StatefulWidget {
  @override
  _FormworkAreaPageState createState() => _FormworkAreaPageState();
}

class _FormworkAreaPageState extends State<FormworkAreaPage> {
  final lengthController = TextEditingController();
  final heightController = TextEditingController();
  String result = "";

  void calculate() {
    double length = double.tryParse(lengthController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;

    if (length <= 0 || height <= 0) {
      setState(() {
        result = "❗ Lütfen uzunluk ve yükseklik değerlerini doğru giriniz.";
      });
      return;
    }

    double area = length * height;

    setState(() {
      result = "💡 Kalıp Alanı: ${area.toStringAsFixed(2)} m²";
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
      appBar: AppBar(title: Text("Kalıp Alanı Hesabı")),
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
                        lengthController, "Uzunluk (m)", Icons.straighten),
                    buildInput(heightController, "Yükseklik (m)", Icons.height),
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
