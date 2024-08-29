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
    CancelToken cancelToken,
    Function(int, int) onReceiveProgress,
    Function(String) onSuccess,
  ) async {
    final fileName = Utility.createEpubFileName(book.title);

    String baseUrl = book.formats.applicationEpubZip ?? "";
    String path = await Utility.getTempFilePath(fileName);

    final tempFile = File(path);

    try {
      await dio
          .download(
        baseUrl,
        path,
        cancelToken: cancelToken,
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
        await tempFile.copy(await Utility.getFilePath(fileName));
        tempFile.delete();
        onSuccess(fileName);
      } catch (ex) {
        print(ex);
      }
    }
  }
}
