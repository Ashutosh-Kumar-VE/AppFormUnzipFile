import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';

class Util {
  Future<File?> startDownloading() async {
    Dio dio = Dio();
    const String url1 =
        'https://firebasestorage.googleapis.com/v0/b/e-commerce-72247.appspot.com/o/195-1950216_led-tv-png-hd-transparent-png.png?alt=media&token=0f8a6dac-1129-4b76-8482-47a6dcc0cd3e';
    const String url = 'https://breath.systems/sample.zip';
    const String fileName = "data.zip";

    String path = await _getFilePath(fileName);
    print("Path : $path");
    await dio.download(
      url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        var progress = recivedBytes / totalBytes;

        print(progress);
      },
      deleteOnError: true,
    ).then((_) {
      print("Done");
    });
    final dir = await getApplicationDocumentsDirectory();
    await archiveFile(path, dir.path);

    String unzipData = "bc010e6ed25b802da7eb-18eaa48addae7e3021f6bcea03b7a6557e3f0132/index.html";
    String indexFilePath = "${dir.path}/$unzipData";
    File data = File(indexFilePath);
    print(await data.exists());
    print("Final path ${data.path}");
    return data;
  }

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();

    return "${dir.path}/$filename";
  }

  Future<void> archiveFile(String filePath, String savePath) async {
    final zipFile = File(filePath);
    final destinationDir = Directory(savePath);
    try {
      ZipFile.extractToDirectory(zipFile: zipFile, destinationDir: destinationDir);
    } catch (e) {
      print(e);
    }
  }
}
