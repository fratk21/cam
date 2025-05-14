import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';

class PdfService {
  static Future<Uint8List> generateSimpleReport(
      String title, String resultText) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(title, style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Text(resultText, style: pw.TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
    return pdf.save();
  }
}
