import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../../services/pdf_service.dart';

class ResultPdfPage extends StatelessWidget {
  final String title;
  final String resultText;

  ResultPdfPage({required this.title, required this.resultText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Önizleme")),
      body: PdfPreview(
        build: (format) => PdfService.generateSimpleReport(title, resultText),
      ),
    );
  }
}
