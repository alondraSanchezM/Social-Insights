import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Init {

  static Future<String> initialize() async {

    
    final String df = await rootBundle.loadString('assets/df_socialMedia_clean.json');

    // final directory = await getApplicationDocumentsDirectory();
    // final path = directory.path;
    // final file = File('$path/credito.txt');

    return df;

  }
  
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/credito.txt');
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$counter');
  }

}