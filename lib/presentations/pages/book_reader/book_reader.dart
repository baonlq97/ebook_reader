import 'dart:io';

import 'package:ebook_reader/common/utils/util.dart';
import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:ebook_reader/gen/fonts.gen.dart';
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
  late Future<void> _loadEpubFuture;

  String? _currentPos;

  @override
  void initState() {
    _loadEpubFuture = _loadEpub();
    super.initState();
  }

  @override
  void deactivate() {
    if (Platform.isAndroid || Platform.isIOS) {
      widget.libraryItem.currentPosition = _currentPos;
      ref
          .read(bookReaderProvider.notifier)
          .saveCurrentPosition(widget.libraryItem);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _epubReaderController.dispose();
    super.dispose();
  }

  Future<void> _loadEpub() async {
    final filePath = await Utility.getFilePath(widget.libraryItem.fileName);
    _epubReaderController = EpubController(
      document: EpubDocument.openFile(
        File.fromUri(
          Uri(
            path: filePath,
          ),
        ),
      ),
      epubCfi: widget.libraryItem.currentPosition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadEpubFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading EPUB"));
        } else {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: EpubViewActualChapter(
                controller: _epubReaderController,
                builder: (chapterValue) => Text(
                  (chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ??
                      ''),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontFamily: FontFamily.pacifico,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            endDrawer: Drawer(
              child: EpubViewTableOfContents(controller: _epubReaderController),
            ),
            body: Builder(
              builder: (context) {
                return EpubView(
                  controller: _epubReaderController,
                  onDocumentError: (error) => Logger(
                    filter: ProductionFilter(),
                  ).e(error),
                  onChapterChanged: (value) => {
                    _currentPos = _epubReaderController.generateEpubCfi(),
                    if (Scaffold.of(context).isEndDrawerOpen)
                      {Navigator.of(context).pop()},
                  },
                  builders: EpubViewBuilders<DefaultBuilderOptions>(
                    options: const DefaultBuilderOptions(),
                    chapterDividerBuilder: (_) => const Divider(),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
