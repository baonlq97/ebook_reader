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
    return Scaffold(
      appBar: TopAppBar(
        headerTitle: "Book Detail",
        iconRes: Assets.drawable.icSearch,
      ),
      body: book.when(
        data: (data) {
          return BookItemCard(
            title: "All books",
            author: "All books",
            language: "All books",
            subjects: "All books",
            coverImageUrl: "",
            onClick: () => {
              downloader.startDownloading(
                context,
                data!,
                (first, second) {
                  print(first / second);
                },
                (path) {
                  print(path);
                },
              )
            },
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
