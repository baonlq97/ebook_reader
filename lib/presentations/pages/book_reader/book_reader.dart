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

  @override
  void initState() {
    _loadEpubFuture = _loadEpub();
    super.initState();
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
    );
  }

  @override
  Widget build(BuildContext context) {
    // final currentIndex = ref.watch(bookReaderProvider);
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
              // Show actual chapter name
              title: EpubViewActualChapter(
                controller: _epubReaderController,
                builder: (chapterValue) => Text(
                  chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ??
                      '',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: FontFamily.pacifico,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            // Show table of contents
            drawer: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 120.0,
                    child: DrawerHeader(
                      // margin: EdgeInsets.all(0.0),
                      // padding: EdgeInsets.all(0.0),
                      child: Text(
                        'Chapters',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: Assets.fonts.figeronaLight,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: EpubViewTableOfContents(
                      controller: _epubReaderController,
                      itemBuilder: (context, index, chapter, itemCount) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (chapter.type == 'chapter')
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: GestureDetector(
                                      child: Text(
                                        chapter.title!,
                                        style: TextStyle(
                                          fontFamily:
                                              Assets.fonts.figeronaLight,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      onTap: () {
                                        _epubReaderController.scrollTo(
                                          index: chapter.startIndex,
                                        );
                                      },
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: GestureDetector(
                                      child: Text(
                                        chapter.title!,
                                        style: TextStyle(
                                          fontFamily:
                                              Assets.fonts.figeronaLight,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 16.0,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
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
      },
    );
  }
}
