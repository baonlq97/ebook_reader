import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:ebook_reader/epub/models/epub_chapter.dart';
import 'package:ebook_reader/epub/models/epub_image.dart';

class EpubBook extends Equatable {
  final String fileName;
  final String title;
  final String author;
  final String language;
  final Image? coverImage; // Assuming coverImage is an Image widget or null
  final List<EpubChapter> chapters;
  final List<EpubImage> images;

  const EpubBook({
    required this.fileName,
    required this.title,
    required this.author,
    required this.language,
    this.coverImage,
    required this.chapters,
    required this.images,
  });

  @override
  List<Object?> get props {
    return [
      fileName,
      title,
      author,
      language,
      coverImage,
      chapters,
      images,
    ];
  }
}
