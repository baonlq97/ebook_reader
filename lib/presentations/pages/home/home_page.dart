import 'package:ebook_reader/common/widgets/book_item_card.dart';
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

  ScrollController _scrollController(WidgetRef ref) {
    final homeNotifier = ref.read(homeNotifierProvider.notifier);

    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !homeNotifier.isLoadingMore) {
        homeNotifier.fetchMoreBooks();
      }
    });

    return scrollController;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookset = ref.watch(homeNotifierProvider);
    return Scaffold(
      appBar: TopAppBar(
          headerTitle: "All books", iconRes: Assets.drawable.icSearch),
      body: bookset.when(
        data: (data) {
          final books = data.bookSet.books;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              controller: _scrollController(ref),
              padding: const EdgeInsets.all(4.0),
              itemCount:
                  data.bookSet.books.length + (data.isLoadingMore ? 1 : 0),
              itemBuilder: (_, index) {
                if (index < books.length) {
                  return BookItemCard(
                    title: books[index].title,
                    author: books[index].authors[0].name,
                    language: books[index].languages[0],
                    subjects: books[index].subjects[0],
                    coverImageUrl: books[index].formats.imageJpeg,
                    onClick: () => {
                      GoRouter.of(context).push(
                        AppRoute.bookDetail.path,
                        extra: {
                          'bookId': books[index].id,
                        },
                      )
                    },
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: LinearProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Oops! Somethings went wrong"),
              ElevatedButton(
                child: const Text('Try Again'),
                onPressed: () {
                  ref.invalidate(homeNotifierProvider);
                },
              ),
            ],
          ),
        ),
        loading: () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const BookItemsShimmer(),
        ),
      ),
    );
  }
}
