import 'dart:io';

import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:ebook_reader/presentations/pages/book_reader/providers/book_reader.dart';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class BookReaderPage extends ConsumerStatefulWidget {
  final LibraryItem libraryItem;
  const BookReaderPage({
    super.key,
    required this.libraryItem,
  });

  @override
  ConsumerState<BookReaderPage> createState() => BookReaderPageState();
}

class BookReaderPageState extends ConsumerState<BookReaderPage> {
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
    final currentIndex = ref.watch(bookReaderProvider);
    return Scaffold(
      appBar: AppBar(
        // Show actual chapter name
        title: EpubViewActualChapter(
          controller: _epubReaderController,
          builder: (chapterValue) => Text(
            chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? 'N/A',
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
          //   if (chapter.type == 'chapter') {
          //     return GestureDetector(
          //       child: Text(
          //         chapter.title!,
          //         style: TextStyle(
          //           color: currentIndex == chapter.startIndex ? Colors.red : Colors.black,
          //           fontFamily: Assets.fonts.figeronaMedium,
          //           fontStyle: FontStyle.normal,
          //           fontSize: 20.0,
          //         ),
          //       ),
          //       onTap: () {
          //         _epubReaderController.scrollTo(
          //           index: chapter.startIndex,
          //         );
          //       },
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
            onDocumentError: (error) => Logger(
              filter: ProductionFilter(),
            ).e(error),
            onChapterChanged: (value) => {
              ref
                  .read(bookReaderProvider.notifier)
                  .setCurrentIndex(value!.chapterNumber),
              if (Scaffold.of(context).isDrawerOpen)
                {Navigator.of(context).pop()},
            },
          );
        },
      ),
    );
  }
}
