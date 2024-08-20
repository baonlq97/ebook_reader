import 'package:ebook_reader/common/widgets/book_item_card.dart';
import 'package:ebook_reader/common/widgets/book_item_shimmer.dart';
import 'package:ebook_reader/common/widgets/book_items_shimmer.dart';
import 'package:ebook_reader/common/widgets/top_app_bar.dart';
import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:ebook_reader/presentations/app_route.dart';
import 'package:ebook_reader/presentations/notifiers/home/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookset = ref.watch(getAllBooksProvider);
    return Scaffold(
      appBar: TopAppBar(
          headerTitle: "All books", iconRes: Assets.drawable.icSearch),
      body: bookset.when(
        data: (data) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
                padding: const EdgeInsets.all(4.0),
                itemCount: data!.books.length,
                itemBuilder: (_, index) {
                  return BookItemCard(
                    title: data.books[index].title,
                    author: data.books[index].authors[0].name,
                    language: data.books[index].languages[0],
                    subjects: data.books[index].subjects[0],
                    coverImageUrl: data.books[index].formats.imageJpeg,
                    onClick: () => {
                      GoRouter.of(context).push(
                        AppRoute.bookDetail.path,
                        extra: {
                          'bookId': data.books[index].id,
                        },
                      )
                    },
                  );
                }),
          );
        },
        error: (error, stackTrace) => Text("error"),
        loading: () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const BookItemsShimmer(),
        ),
      ),
    );
  }
}
