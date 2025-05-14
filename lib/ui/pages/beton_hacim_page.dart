import 'package:flutter/material.dart';
import 'package:cam/services/statik_service.dart';

class BetonHacimPage extends StatefulWidget {
  @override
  _BetonHacimPageState createState() => _BetonHacimPageState();
}

class _BetonHacimPageState extends State<BetonHacimPage> {
  final areaController = TextEditingController();
  final thicknessController = TextEditingController();
  String result = "";

  void calculate() {
    double area = double.tryParse(areaController.text) ?? 0;
    double thickness = double.tryParse(thicknessController.text) ?? 0;

    if (area <= 0 || thickness <= 0) {
      setState(() {
        result = "❗ Lütfen alan ve kalınlık değerlerini doğru giriniz.";
      });
      return;
    }

    double volume = StatikService.calculateConcreteVolume(area, thickness);

    setState(() {
      result = "🔹 Beton Hacmi: ${volume.toStringAsFixed(2)} m³";
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
      appBar: AppBar(title: Text("Beton Hacmi Hesabı")),
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
                    buildInput(areaController, "Alan (m²)", Icons.square_foot),
                    buildInput(
                        thicknessController, "Kalınlık (m)", Icons.height),
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
