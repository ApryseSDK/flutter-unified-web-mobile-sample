import 'package:flutter/material.dart';
import 'package:myapp/pdfviewer/pdfviewer_interface.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PDFViewer();
  }
}
