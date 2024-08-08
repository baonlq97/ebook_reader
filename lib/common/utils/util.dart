import 'package:ebook_reader/common/constant/constant.dart';

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
}
