import 'package:flutter/material.dart';

class SafeSlopePage extends StatefulWidget {
  @override
  _SafeSlopePageState createState() => _SafeSlopePageState();
}

class _SafeSlopePageState extends State<SafeSlopePage> {
  final factorController = TextEditingController();
  String result = "";

  void calculate() {
    double factor = double.tryParse(factorController.text) ?? 0;

    if (factor <= 0) {
      setState(() {
        result =
            "❗ Lütfen zemin türü faktörünü doğru ve sıfırdan büyük giriniz.";
      });
      return;
    }

    setState(() {
      result = "💡 Önerilen Şev Açısı: ${factor.toStringAsFixed(1)}°";
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
      appBar: AppBar(title: Text("Şev Açısı Hesabı")),
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
                    buildInput(factorController, "Zemin Türü Faktörü (°)",
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
