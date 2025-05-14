import 'package:flutter/material.dart';

class MaterialConverterPage extends StatefulWidget {
  @override
  _MaterialConverterPageState createState() => _MaterialConverterPageState();
}

class _MaterialConverterPageState extends State<MaterialConverterPage> {
  final valueController = TextEditingController();
  final densityController = TextEditingController();
  final wasteController = TextEditingController();
  String from = "m³";
  String to = "kg";
  String result = "";

  void calculate() {
    double value = double.tryParse(valueController.text) ?? 0;
    double density = double.tryParse(densityController.text) ?? 0;
    double waste = double.tryParse(wasteController.text) ?? 0;

    if (value <= 0 || density <= 0) {
      setState(() {
        result =
            "❗ Lütfen değer ve yoğunluk doğru ve sıfırdan büyük olmalıdır.";
      });
      return;
    }

    double valueWithWaste = value * (1 + waste / 100);
    double resultValue = 0;
    if (from == "m³" && to == "kg") resultValue = valueWithWaste * density;
    if (from == "kg" && to == "m³") resultValue = valueWithWaste / density;
    if (from == "m³" && to == "ton")
      resultValue = (valueWithWaste * density) / 1000;
    if (from == "ton" && to == "m³")
      resultValue = (valueWithWaste * 1000) / density;

    setState(() {
      result = "💡 Sonuç (Fireli): ${resultValue.toStringAsFixed(2)} $to";
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
      String label, String value, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: SizedBox(),
            items: ["m³", "kg", "ton"]
                .map((e) => DropdownMenuItem(child: Text(e), value: e))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Malzeme Dönüştürücü + Fire")),
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
                    buildInput(valueController, "Değer", Icons.linear_scale),
                    buildInput(
                        densityController, "Yoğunluk (kg/m³)", Icons.compress),
                    buildInput(wasteController, "Fire (%)", Icons.percent),
                    buildDropdown(
                        "Dönüştür", from, (v) => setState(() => from = v!)),
                    buildDropdown("Sonuç", to, (v) => setState(() => to = v!)),
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
