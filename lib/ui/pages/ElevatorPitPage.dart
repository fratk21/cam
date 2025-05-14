import 'package:flutter/material.dart';

class ElevatorPitPage extends StatefulWidget {
  @override
  _ElevatorPitPageState createState() => _ElevatorPitPageState();
}

class _ElevatorPitPageState extends State<ElevatorPitPage> {
  final widthController = TextEditingController();
  final lengthController = TextEditingController();
  final heightController = TextEditingController();
  String result = "";

  void calculate() {
    double w = double.tryParse(widthController.text) ?? 0;
    double l = double.tryParse(lengthController.text) ?? 0;
    double h = double.tryParse(heightController.text) ?? 0;

    if (w <= 0 || l <= 0 || h <= 0) {
      setState(() {
        result = "❗ Lütfen tüm ölçüleri doğru ve sıfırdan büyük giriniz.";
      });
      return;
    }

    double concreteVolume = w * l * h;
    double formworkArea = 2 * (w + l) * h;

    setState(() {
      result =
          "💡 Beton Hacmi: ${concreteVolume.toStringAsFixed(2)} m³\n💡 Kalıp Alanı: ${formworkArea.toStringAsFixed(2)} m²";
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
      appBar: AppBar(title: Text("Asansör Kuyu Hesabı")),
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
                    buildInput(widthController, "Kuyu Genişliği (m)",
                        Icons.width_full),
                    buildInput(lengthController, "Kuyu Uzunluğu (m)",
                        Icons.crop_landscape),
                    buildInput(
                        heightController, "Kuyu Yüksekliği (m)", Icons.height),
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
