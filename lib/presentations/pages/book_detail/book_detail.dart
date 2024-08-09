import 'package:ebook_reader/common/helper/book/book_util.dart';
import 'package:ebook_reader/common/provider/book_downloader/book_downloader_provider.dart';
import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:ebook_reader/presentations/notifiers/book_detail/book_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ebook_reader/common/helper/book/book_downloader.dart';
import 'package:ebook_reader/common/widgets/book_item_card.dart';
import 'package:ebook_reader/common/widgets/top_app_bar.dart';
import 'package:ebook_reader/gen/assets.gen.dart';

class BookDetailPage extends ConsumerWidget {
  final int bookId;
  final BookDownloader downloader = BookDownloader();

  BookDetailPage({
    super.key,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(getBookDetailProvider(bookId));
    final downloadProgress = ref.watch(downloadNotifierProvider);
    final downloader = ref.read(downloadNotifierProvider.notifier);
    final getBookById = ref.read(getBookByIdProvider(bookId));

    return Scaffold(
      appBar: TopAppBar(
        headerTitle: "Book Detail",
        iconRes: Assets.drawable.icSearch,
      ),
      body: book.when(
        data: (data) {
          final book = data!.books.first;
          final libraryItemProvider = ref.watch(getBookByIdProvider(book.id));
          return Column(
            children: [
              BookItemCard(
                title: "All books",
                author: "All books",
                language: "All books",
                subjects: "All books",
                coverImageUrl: "",
                onClick: () => {
                  downloader.startDownloading(
                    context,
                    book,
                    (path) {
                      final insertItemNotifier =
                          ref.watch(insertItemProvider.notifier);

                      insertItemNotifier
                          .insert(
                        LibraryItem(
                          bookId: book.id,
                          title: book.title,
                          authors: BookUtil.getAuthorsAsString(book.authors),
                          filePath: path,
                          createdAt: DateTime.now().millisecondsSinceEpoch,
                        ),
                      )
                          .then((_) {
                        ref.read(getBookByIdProvider(book.id));
                      });
                    },
                  )
                },
              ),
              if (downloadProgress < 1.0)
                Column(
                  children: [
                    LinearProgressIndicator(
                      value: downloadProgress,
                    ),
                    Text(
                      '${downloadProgress * 100}% downloaded',
                    ),
                  ],
                ),
              if (downloadProgress == 1.0)
                ElevatedButton(
                  child: Text('Read book'),
                  onPressed: () {
                    libraryItemProvider.whenData((libraryItem) async => {
                          
                        });
                  },
                ),
              getBookById.when(
                data: (data) {
                  return ElevatedButton(
                      child: Text('Read book'),
                      onPressed: () {
                        libraryItemProvider.whenData((libraryItem) => {
                              print(libraryItem!.filePath),
                            });
                      });
                },
                error: (error, stackTrace) => const Icon(Icons.error),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
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
