import 'package:flutter/material.dart';
import '../../services/statik_service.dart';

class KesmeGerilmePage extends StatefulWidget {
  @override
  _KesmeGerilmePageState createState() => _KesmeGerilmePageState();
}

class _KesmeGerilmePageState extends State<KesmeGerilmePage> {
  final shearController = TextEditingController();
  final areaController = TextEditingController();
  String result = "";

  void calculate() {
    double shear = double.tryParse(shearController.text) ?? 0;
    double area = double.tryParse(areaController.text) ?? 0;

    if (shear <= 0 || area <= 0) {
      setState(() {
        result = "❗ Lütfen kesme kuvveti ve alan değerlerini doğru giriniz.";
      });
      return;
    }

    double stress = StatikService.calculateShearStress(shear, area);

    setState(() {
      result = "💡 Kesme Gerilmesi: ${stress.toStringAsFixed(2)} N/mm²";
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
      appBar: AppBar(title: Text("Kesme Gerilmesi Hesabı")),
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
                        shearController, "Kesme Kuvveti (N)", Icons.call_split),
                    buildInput(areaController, "Alan (mm²)", Icons.square_foot),
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
