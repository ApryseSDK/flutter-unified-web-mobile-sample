import 'package:flutter/material.dart';

import 'dart:ui' as ui;
import 'dart:html' as html;

import 'package:myapp/pdfviewer/pdfviewer_interface.dart';

class WebViewer extends StatefulWidget implements PDFViewer {
  final String _document;

  WebViewer(this._document);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _WebViewerState createState() => _WebViewerState();
}

class _WebViewerState extends State<WebViewer> {
  String viewID = "webviewer-id";
  html.DivElement _element;

  @override
  void initState() {
    super.initState();

    _element = html.DivElement()
      ..id = 'canvas'
      ..append(html.ScriptElement()
        ..text = """
        const canvas = document.querySelector("flt-platform-view").shadowRoot.querySelector("#canvas");
        WebViewer({
          path: 'WebViewer/lib',
          initialDoc: '${widget._document}'
        }, canvas).then((instance) => {
            // call apis here
        });
        """);

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(viewID, (int viewId) => _element);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Container(
        alignment: Alignment.center,
        child: HtmlElementView(
          viewType: viewID,
        ),
      ),
    );
  }
}

PDFViewer getPDFViewer(String document) => WebViewer(document);
