import 'package:flutter/material.dart';

class ConcreteMixPage extends StatefulWidget {
  @override
  _ConcreteMixPageState createState() => _ConcreteMixPageState();
}

class _ConcreteMixPageState extends State<ConcreteMixPage> {
  final volumeController = TextEditingController();
  String selectedGrade = "C20";
  String result = "";

  void calculate() {
    double volume = double.tryParse(volumeController.text) ?? 0;

    if (volume <= 0) {
      setState(() {
        result = "❗ Lütfen beton hacmini doğru giriniz.";
      });
      return;
    }

    Map<String, double> mix = selectedGrade == "C20"
        ? {
            "Çimento (kg)": 320 * volume,
            "Kum (kg)": 660 * volume,
            "Çakıl (kg)": 1200 * volume,
            "Su (kg)": 160 * volume,
          }
        : {
            "Çimento (kg)": 340 * volume,
            "Kum (kg)": 650 * volume,
            "Çakıl (kg)": 1250 * volume,
            "Su (kg)": 165 * volume,
          };

    result = mix.entries
        .map((e) => "💡 ${e.key}: ${e.value.toStringAsFixed(1)}")
        .join("\n");

    setState(() {});
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

  Widget buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton<String>(
            value: selectedGrade,
            isExpanded: true,
            items: ["C20", "C25"]
                .map((e) => DropdownMenuItem(child: Text(e), value: e))
                .toList(),
            onChanged: (v) => setState(() => selectedGrade = v!),
            underline: SizedBox(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Beton Karışım Hesabı")),
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
                    buildInput(volumeController, "Beton Hacmi (m³)",
                        Icons.cloud_queue),
                    buildDropdown(),
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
