import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ebook_reader/common/utils/util.dart';
import 'package:ebook_reader/data/models/api/book/book.dart';

class BookDownloader {
  final Dio dio;
  bool isSuccess;

  BookDownloader({
    required this.dio,
    this.isSuccess = false,
  });

  Future<void> startDownloading(
    BuildContext context,
    Book book,
    Function(int, int) onReceiveProgress,
    Function(String) onSuccess,
  ) async {
    final fileName = Utility.createEpubFileName(book.title);

    String baseUrl = book.formats.applicationEpubZip ?? "";
    String path = await _getTempFilePath(fileName);

    final tempFile = File(path);

    try {
      await dio
          .download(
        baseUrl,
        path,
        onReceiveProgress: onReceiveProgress,
        deleteOnError: true,
      )
          .then((_) {
        isSuccess = true;
      });
    } catch (e) {
      print("Exception$e");
    }

    if (isSuccess) {
      try {
        final bookFilePath = await _getFilePath(fileName);
        final bookFile = await tempFile.copy(bookFilePath);
        tempFile.delete();
        onSuccess(bookFile.absolute.path);
      } catch (ex) {
        print(ex);
      }
    }
  }

  Future<String> _getTempFilePath(String filename) async {
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

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      dir = await getApplicationSupportDirectory();
    } catch (err) {
      print("Cannot get folder path $err");
    }
    return "${dir?.path}/$filename";
  }
}
