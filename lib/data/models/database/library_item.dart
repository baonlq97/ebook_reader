import 'dart:io';

import 'package:ebook_reader/common/utils/util.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

part 'library_item.g.dart';

@collection
@Name('book_library')
class LibraryItem {
  Id id;

  @Name('book_id')
  int bookId;

  String title;

  String authors;

  @Name('file_name')
  String fileName;

  @Name('is_external_book')
  bool isExternalBook;

  @Name('created_at')
  int createdAt;

  LibraryItem({
    this.id = Isar.autoIncrement,
    required this.bookId,
    required this.title,
    required this.authors,
    required this.fileName,
    this.isExternalBook = false,
    required this.createdAt,
  });

  Future<bool> fileExists(String fileName) async {
    final filePath = await Utility.getFilePath(fileName);
    final file = File(filePath);
    return file.existsSync();
  }

  Future<String> getFileSize(String fileName) async {
    final filePath = await Utility.getFilePath(fileName);
    final file = File(filePath);
    int bytes = file.lengthSync();

    if (-1000 < bytes && bytes < 1000) {
      return '$bytes B';
    }

    const units = ['k', 'M', 'G', 'T', 'P', 'E'];
    int unitIndex = 0;

    while (bytes.abs() >= 999950) {
      bytes ~/= 1000;
      unitIndex++;
    }

    double formattedSize = bytes / 1000.0;
    return '${formattedSize.toStringAsFixed(1)} ${units[unitIndex]}B';
  }

  String getDownloadDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat.yMMMd().format(date); // Example format: Jan 1, 2024
  }

  Future<bool> deleteFile(String fileName) async {
    final filePath = await Utility.getFilePath(fileName);
    final file = File(filePath);
    try {
      file.deleteSync();
      return true;
    } catch (e) {
      return false;
    }
  }
}
