import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ebook_reader/common/utils/util.dart';
import 'package:ebook_reader/domain/models/book/book.dart';
import 'package:ebook_reader/domain/models/book_set/book_set.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BookDownloader {
  Dio dio = Dio();
  bool isSuccess = false;

  BookDownloader();

  Future<void> startDownloading(
    BuildContext context,
    BookSet bookSet,
    Function(int, int) onReceiveProgress,
    Function(String) onSuccess,
  ) async {
    final fileName = Utility.createEpubFileName(bookSet.books.first.title);

    String baseUrl = bookSet.books.first.formats.applicationEpubZip;
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
      }
      catch(ex) {
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
