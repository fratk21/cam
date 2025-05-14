import 'package:flutter/material.dart';

class LabourCostPage extends StatefulWidget {
  @override
  _LabourCostPageState createState() => _LabourCostPageState();
}

class _LabourCostPageState extends State<LabourCostPage> {
  final quantityController = TextEditingController();
  final unitPriceController = TextEditingController();
  String result = "";

  void calculate() {
    double quantity = double.tryParse(quantityController.text) ?? 0;
    double unitPrice = double.tryParse(unitPriceController.text) ?? 0;

    if (quantity <= 0 || unitPrice <= 0) {
      setState(() {
        result =
            "❗ Lütfen miktar ve birim fiyatı doğru ve sıfırdan büyük giriniz.";
      });
      return;
    }

    double total = quantity * unitPrice;

    setState(() {
      result = "💡 Toplam Maliyet: ${total.toStringAsFixed(2)} TL";
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
      appBar: AppBar(title: Text("İşçilik Maliyeti Hesabı")),
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
                    buildInput(quantityController, "Miktar",
                        Icons.format_list_numbered),
                    buildInput(unitPriceController, "Birim Fiyat (TL)",
                        Icons.attach_money),
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
