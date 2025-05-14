import 'package:flutter/material.dart';

class UnitConverterPage extends StatefulWidget {
  @override
  _UnitConverterPageState createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  final valueController = TextEditingController();
  final densityController = TextEditingController();
  String from = "m³";
  String to = "kg";
  String result = "";

  void calculate() {
    double value = double.tryParse(valueController.text) ?? 0;
    double density = double.tryParse(densityController.text) ?? 0;

    if (value <= 0 || (from != "litre" && to != "litre" && density <= 0)) {
      setState(() {
        result = "❗ Lütfen değer ve yoğunluğu doğru giriniz.";
      });
      return;
    }

    double resultValue = 0;
    if (from == "m³" && to == "kg") resultValue = value * density;
    if (from == "m³" && to == "ton") resultValue = (value * density) / 1000;
    if (from == "kg" && to == "m³") resultValue = value / density;
    if (from == "ton" && to == "m³") resultValue = (value * 1000) / density;
    if (from == "litre" && to == "m³") resultValue = value / 1000;
    if (from == "m³" && to == "litre") resultValue = value * 1000;

    setState(() {
      result = "💡 Sonuç: ${resultValue.toStringAsFixed(2)} $to";
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

  Widget buildDropdown(
      String value, void Function(String?) onChanged, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: ["m³", "kg", "ton", "litre"]
            .map((e) => DropdownMenuItem(child: Text(e), value: e))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Birim Dönüştürücü")),
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
                    buildInput(valueController, "Değer", Icons.swap_horiz),
                    buildInput(densityController, "Yoğunluk (kg/m³)",
                        Icons.bubble_chart),
                    buildDropdown(from, (v) => setState(() => from = v!),
                        "Dönüştürülecek Birim"),
                    buildDropdown(
                        to, (v) => setState(() => to = v!), "Hedef Birim"),
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
