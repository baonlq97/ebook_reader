import 'dart:io';

import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:ebook_reader/presentations/notifiers/book_detail/book_detail_notifier.dart';
import 'package:ebook_reader/presentations/notifiers/book_reader/book_reader.dart';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_file/internet_file.dart';

class BookReaderPage extends StatefulWidget {
  final LibraryItem libraryItem;
  const BookReaderPage({
    super.key,
    required this.libraryItem,
  });

  @override
  State<BookReaderPage> createState() => BookReaderPageState();
}

class BookReaderPageState extends State<BookReaderPage> {
  late EpubController _epubReaderController;

  @override
  void initState() {
    super.initState();
    _loadEpub();
  }

  void _loadEpub() {
    _epubReaderController = EpubController(
      document: EpubDocument.openFile(
        File.fromUri(
          Uri(path: widget.libraryItem.filePath),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Show actual chapter name
        title: EpubViewActualChapter(
          controller: _epubReaderController,
          builder: (chapterValue) => Text(
            'Chapter: ' +
                (chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ??
                    ''),
            textAlign: TextAlign.start,
            maxLines: 2,
          ),
        ),
      ),
      // Show table of contents
      drawer: Drawer(
        child: EpubViewTableOfContents(
          controller: _epubReaderController,
          // itemBuilder: (context, index, chapter, itemCount) {
          //   // final currentIndex = ref.read(bookReaderProvider);
          //   if (chapter.type == 'chapter') {
          //     return GestureDetector(
          //       child: Text(
          //         chapter.title!,
          //         // style: TextStyle(
          //         //   color: currentIndex == index
          //         //       ? Colors.red
          //         //       : Colors.black,
          //         // ),
          //       ),
          //       onTap: () => _epubReaderController.scrollTo(
          //         index: chapter.startIndex,
          //       ),
          //     );
          //   }
          //   return const SizedBox.shrink();
          // },
        ),
      ),
      body: Builder(
        builder: (context) {
          return EpubView(
            controller: _epubReaderController,
            onDocumentError: (error) => print(error),
            onChapterChanged: (value) => {
              // ref.read(bookReaderProvider.notifier).setCurrentIndex(value!.position.index),
              if (Scaffold.of(context).isDrawerOpen)
                {Navigator.of(context).pop()},
            },
          );
        }
      ),
    );
  }
}
