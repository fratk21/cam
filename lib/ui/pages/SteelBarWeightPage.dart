import 'package:flutter/material.dart';
import 'package:cam/services/statik_service.dart';

class SteelBarWeightPage extends StatefulWidget {
  @override
  _SteelBarWeightPageState createState() => _SteelBarWeightPageState();
}

class _SteelBarWeightPageState extends State<SteelBarWeightPage> {
  final diameterController = TextEditingController();
  final lengthController = TextEditingController();
  String result = "";

  void calculate() {
    double diameter = double.tryParse(diameterController.text) ?? 0;
    double length = double.tryParse(lengthController.text) ?? 0;

    if (diameter <= 0 || length <= 0) {
      setState(() {
        result = "❗ Lütfen çap ve uzunluğu doğru ve sıfırdan büyük giriniz.";
      });
      return;
    }

    double weight = StatikService.calculateSteelBarWeight(diameter, length);

    setState(() {
      result = "💡 Ağırlık: ${weight.toStringAsFixed(2)} kg";
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
      appBar: AppBar(title: Text("Çubuk Çelik Ağırlık Hesabı")),
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
                    buildInput(diameterController, "Çap (mm)", Icons.swap_vert),
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
