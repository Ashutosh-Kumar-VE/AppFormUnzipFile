import 'dart:io';

import 'package:downloadingurl/util.dart';
import 'package:downloadingurl/view.dart';

import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
  }

  Future getPermission() async {
    var storage = await Permission.storage.request();
    if (storage.isGranted) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      print("Granted");
    } else {
      print("Denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  File? file = await Util().startDownloading();
                  if (file != null) {
                    await Future.delayed(const Duration(seconds: 1));
                    if (!mounted) return;
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ViewPage(file: file)));
                  }
                },
                child: Text("Download Zip File")),
          ],
        ));
  }
}
