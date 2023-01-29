import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewPage extends StatefulWidget {
  final File file;

  const ViewPage({Key? key, required this.file}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Html Loaded File'),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: 'about:blank',
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          // _loadHtmlFromAssets();
          _loadHtmlFromFile();
        },
      ),
    );
  }

  _loadHtmlFromFile() async {
    // String fileText = await rootBundle.loadString('assets/index.html');
    // FilePickerResult? result = await FilePicker.platform.pickFiles();

    // if (result != null) {
    //   File file = File(result.files.single.path!);
    // } else {
    //   // User canceled the picker
    // }
    _controller!.loadFile(widget.file.path);
  }
}
