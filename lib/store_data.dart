import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class StoreHighScore {

  Future <File> createFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    File file = File("$path/highscore.txt");
    return await file.create();
  }

  Future <String> get localPath async {
    Directory directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future <File> get localFile async {
    String path = await localPath;
    debugPrint(path);
    
    return File("$path/highscore.txt");
  }

  Future <int> readHighScore() async {
    try {
      File file = await localFile;
      final String contents = await file.readAsString();
      return int.parse(contents);
    }
    catch (e) {
      return 0;
    }
  }

  Future <File> writeHighScore(int newHighScore) async {
    File file = await localFile;
    return file.writeAsString("$newHighScore");
  }

  Future deleteFile() async {
    try {
      File file = await localFile;
      await file.delete();
    } catch (e) {
      rethrow;
    }
  }

}