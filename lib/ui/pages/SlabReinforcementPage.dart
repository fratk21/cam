import 'package:flutter/material.dart';

class SlabReinforcementPage extends StatefulWidget {
  @override
  _SlabReinforcementPageState createState() => _SlabReinforcementPageState();
}

class _SlabReinforcementPageState extends State<SlabReinforcementPage> {
  final momentController = TextEditingController();
  final depthController = TextEditingController();
  final fydController = TextEditingController();
  String result = "";

  void calculate() {
    double moment = double.tryParse(momentController.text) ?? 0;
    double depth = double.tryParse(depthController.text) ?? 0;
    double fyd = double.tryParse(fydController.text) ?? 0;

    if (moment <= 0 || depth <= 0 || fyd <= 0) {
      setState(() {
        result = "❗ Lütfen tüm değerleri doğru ve sıfırdan büyük giriniz.";
      });
      return;
    }

    double as = (moment * 1e6) / (0.9 * depth * fyd);

    setState(() {
      result = "💡 Gerekli As: ${as.toStringAsFixed(2)} mm²";
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
      appBar: AppBar(title: Text("Döşeme Donatı Hesabı")),
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
                        momentController, "Moment (kNm)", Icons.settings),
                    buildInput(
                        depthController, "Etkiyen Mesafe (mm)", Icons.height),
                    buildInput(
                        fydController, "Donatı Dayanımı (N/mm²)", Icons.shield),
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
