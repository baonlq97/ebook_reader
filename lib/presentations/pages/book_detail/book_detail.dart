import 'package:ebook_reader/common/helper/book/book_util.dart';
import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:ebook_reader/presentations/app_route.dart';
import 'package:ebook_reader/presentations/notifiers/book_detail/book_detail_notifier.dart';
import 'package:ebook_reader/presentations/pages/book_detail/widgets/book_detail_middle_bar.dart';
import 'package:ebook_reader/presentations/pages/book_detail/widgets/book_detail_top_bar.dart';
import 'package:ebook_reader/presentations/pages/book_detail/widgets/book_detail_top_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ebook_reader/common/widgets/book_item_card.dart';
import 'package:go_router/go_router.dart';

class BookDetailPage extends ConsumerWidget {
  final int bookId;

  const BookDetailPage({
    super.key,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookDetail = ref.watch(bookDetailProvider);
    final bookDetailNotifier = ref.read(bookDetailProvider.notifier);

    ref.listen<AsyncValue<BookDetailPageState?>>(bookDetailProvider,
        (previous, next) {
      if (next.value?.bookSet == null) {
        bookDetailNotifier.getBookDetail(bookId);
      } else if (next.value?.libraryItem == null) {
        bookDetailNotifier.getBookById(bookId);
      }
    });

    return Scaffold(
      appBar: BookDetailTopBar(
        onBackClick: () {
          GoRouter.of(context).pop();
        },
        onShareClick: () {},
      ),
      body: bookDetail.when(
        data: (data) {
          if (data == null || data.bookSet == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final book = data.bookSet!.books.first;
          final buttonText =
              data.libraryItem != null ? 'Start Reading' : 'Download';

          return Column(
            children: [
              BookDetailTopUI(
                title: book.title,
                authors: book.authors.isNotEmpty ? book.authors[0].name : "",
                currentThemeMode: ThemeMode.light,
                imageData: book.formats.imageJpeg,
              ),
              BookDetailMiddleBar(
                bookLang: book.languages[0],
                buttonText: buttonText,
                downloadCount: "100",
                onButtonClick: () {
                  if (buttonText == 'Start Reading') {
                    GoRouter.of(context).push(
                      AppRoute.bookReader.path,
                      extra: {
                        'libraryItem': data.libraryItem,
                      },
                    );
                  } else {
                    bookDetailNotifier.startDownloading(
                      context,
                      book,
                      (path) {
                        bookDetailNotifier
                            .insert(
                          LibraryItem(
                            bookId: book.id,
                            title: book.title,
                            authors: BookUtil.getAuthorsAsString(
                              book.authors,
                            ),
                            filePath: path,
                            createdAt: DateTime.now().millisecondsSinceEpoch,
                          ),
                        )
                            .then((_) {
                          bookDetailNotifier.getBookById(bookId);
                        });
                      },
                    );
                  }
                },
                pageCount: "100",
                progressValue: bookDetail.value!.downloadProgress,
                showProgressBar: bookDetail.value!.downloadProgress > 0 &&
                    bookDetail.value!.downloadProgress < 1.0,
              )
            ],
          );
        },
        error: (error, stackTrace) => const Icon(Icons.error),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
