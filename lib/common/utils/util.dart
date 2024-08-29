import 'dart:io';

import 'package:ebook_reader/common/constant/constant.dart';
import 'package:path_provider/path_provider.dart';

class Utility {
  static String createEpubFileName(String title) {
    const int maxFileNameLength = MAX_FILENAME_LENGTH;

    String sanitizedTitle = title
        .replaceAll(":", ";")
        .replaceAll("\"", "")
        .replaceAll("/", "-")
        .replaceAll("\\", "-")
        .split(" ")
        .map((word) {
      // Replace non-ASCII characters
      return word.replaceAll(RegExp(r'[^\x00-\x7F]'), '');
    }).join("+");

    // Trim to MAX_FILENAME_LENGTH
    if (sanitizedTitle.length > maxFileNameLength) {
      sanitizedTitle = sanitizedTitle.substring(0, maxFileNameLength).trim();
    }

    return "$sanitizedTitle.epub";
  }

  static Future<String> getTempFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      } else {
        dir = await getExternalStorageDirectory();
      }
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    return "${dir?.path}/$filename";
  }

  static Future<String> getFilePath(String filename) async {
    Directory? dir;

    try {
      dir = await getApplicationSupportDirectory();
    } catch (err) {
      print("Cannot get folder path $err");
    }
    return "${dir?.path}/$filename";
  }
}
