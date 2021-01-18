import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/pdfviewer/pdfviewer_interface.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class NativeViewer extends StatefulWidget implements PDFViewer {
  final String _document;

  NativeViewer(this._document);

  @override
  _NativeViewerState createState() => _NativeViewerState();
}

class _NativeViewerState extends State<NativeViewer> {
  String _version = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String version;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      PdftronFlutter.initialize("your_pdftron_license_key");
      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _version = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: DocumentView(
        onCreated: onDocumentViewCreated,
      ),
    ));
  }

  void onDocumentViewCreated(DocumentViewController controller) {
    if (Platform.isIOS) {
      showViewer(controller);
    } else {
      launchWithPermission(controller);
    }
  }

  Future<void> launchWithPermission(DocumentViewController controller) async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    if (granted(permissions[PermissionGroup.storage])) {
      showViewer(controller);
    }
  }

  bool granted(PermissionStatus status) {
    return status == PermissionStatus.granted;
  }

  void showViewer(DocumentViewController controller) {
    // shows how to disable functionality
    //  var disabledElements = [Buttons.shareButton, Buttons.searchButton];
    //  var disabledTools = [Tools.annotationCreateLine, Tools.annotationCreateRectangle];
    var config = Config();
    //  config.disabledElements = disabledElements;
    //  config.disabledTools = disabledTools;
    //  PdftronFlutter.openDocument(_document, config: config);

    // opening without a config file will have all functionality enabled.
    controller.openDocument(widget._document, config: config);
  }
}

PDFViewer getPDFViewer(String document) => NativeViewer(document);
