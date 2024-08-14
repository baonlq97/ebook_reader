import 'dart:io';
import 'dart:ui';

import 'package:ebook_reader/epub/models/epub_book.dart';
import 'package:ebook_reader/epub/models/epub_chapter.dart';
import 'package:ebook_reader/epub/models/epub_image.dart';
import 'package:epubx/epubx.dart' as epubx;

// class EpubParser {
//   static Future<EpubBook> convertToModel(String filePath) async {
//     // Load the EPUB file into memory
//     File targetFile = File(filePath);
//     List<int> bytes = await targetFile.readAsBytes();

//     // Read the EPUB book
//     epubx.EpubBook epubBook = await epubx.EpubReader.readBook(bytes);

//     epubx.EpubMetadata? metadata = epubBook.Schema?.Package?.Metadata;

//     // Extract metadata
//     String title = epubBook.Title ?? 'Unknown Title';
//     String author = epubBook.Author ?? 'Unknown Author';
//     // String language = epubBookRef ?? 'Unknown Language';

//     // Extract cover image
//     Image? coverImage = epubBook.CoverImage as Image?;

//     List<EpubChapter> chapters = List.empty();

//     // Extract images
//     // List<EpubImage> images = [];
//     // for (var imageEntry in epubBook.Content.Images?.entries) {
//     //   images.add(EpubImage(
//     //     absPath: imageEntry.key,
//     //     image: imageEntry.value.Content,
//     //   ));
//     // }

//     // Return the final EpubBook model
//     return EpubBook(
//       fileName: targetFile.path.split('/').last,
//       title: title,
//       author: author,
//       language: language,
//       coverImage: coverImage,
//       chapters: chapters,
//       images: images,
//     );
//   }
// }
