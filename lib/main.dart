import 'package:flutter/material.dart';
import 'package:myapp/pdfviewer/pdfviewer_interface.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String document =
        "https://pdftron.s3.amazonaws.com/downloads/pl/PDFTRON_about.pdf";
    return MaterialApp(
      home: PDFViewer(document),
    );
  }
}
