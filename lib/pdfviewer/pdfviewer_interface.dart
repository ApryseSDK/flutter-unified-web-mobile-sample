import 'package:flutter/material.dart';

import 'pdfviewer_unsupported.dart'
    if (dart.library.io) 'pdfviewer_mobile.dart'
    if (dart.library.html) 'pdfviewer_web.dart';

abstract class PDFViewer extends Widget {
  factory PDFViewer() => getPDFViewer();
}
