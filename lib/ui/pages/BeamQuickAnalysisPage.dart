import 'package:flutter/material.dart';

class BeamQuickAnalysisPage extends StatefulWidget {
  @override
  _BeamQuickAnalysisPageState createState() => _BeamQuickAnalysisPageState();
}

class _BeamQuickAnalysisPageState extends State<BeamQuickAnalysisPage> {
  final momentController = TextEditingController();
  final shearController = TextEditingController();
  final widthController = TextEditingController();
  final depthController = TextEditingController();
  String result = "";

  void calculate() {
    double M = double.tryParse(momentController.text) ?? 0;
    double V = double.tryParse(shearController.text) ?? 0;
    double b = double.tryParse(widthController.text) ?? 0;
    double h = double.tryParse(depthController.text) ?? 0;

    if (b <= 0 || h <= 0) {
      setState(() {
        result = "Lütfen tüm değerleri geçerli ve sıfırdan büyük giriniz.";
      });
      return;
    }

    double bendingStress = M * 1000000 / (b * h * h / 6);
    double shearStress = V * 1000 / (b * h);

    setState(() {
      result =
          "💡 Eğilme Gerilmesi: ${bendingStress.toStringAsFixed(2)} N/mm²\n💡 Kesme Gerilmesi: ${shearStress.toStringAsFixed(2)} N/mm²";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kiriş Eğilme / Kesme Analizi")),
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
                        momentController, "Moment (kNm)", Icons.sync_alt),
                    buildInput(shearController, "Kesme Kuvveti (kN)",
                        Icons.call_split),
                    buildInput(widthController, "Kiriş Genişliği (mm)",
                        Icons.width_full),
                    buildInput(
                        depthController, "Kiriş Yüksekliği (mm)", Icons.height),
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
}
