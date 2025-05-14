import 'package:flutter/material.dart';
import '../../services/statik_service.dart';

class KirisEgilmePage extends StatefulWidget {
  @override
  _KirisEgilmePageState createState() => _KirisEgilmePageState();
}

class _KirisEgilmePageState extends State<KirisEgilmePage> {
  final momentController = TextEditingController();
  final sectionModulusController = TextEditingController();
  String result = "";

  void calculate() {
    double moment = double.tryParse(momentController.text) ?? 0;
    double sectionModulus = double.tryParse(sectionModulusController.text) ?? 0;

    if (moment <= 0 || sectionModulus <= 0) {
      setState(() {
        result = "❗ Lütfen moment ve kesit modülü değerlerini doğru giriniz.";
      });
      return;
    }

    double stress =
        StatikService.calculateBendingStress(moment, sectionModulus);

    setState(() {
      result = "💡 Eğilme Gerilmesi: ${stress.toStringAsFixed(2)} N/mm²";
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
      appBar: AppBar(title: Text("Kiriş Eğilme Hesabı")),
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
                        momentController, "Moment (N.mm)", Icons.settings),
                    buildInput(sectionModulusController, "Kesit Modülü (mm³)",
                        Icons.grid_4x4),
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
