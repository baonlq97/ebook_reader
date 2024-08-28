import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ebook_reader/common/widgets/book_item_card.dart';
import 'package:ebook_reader/common/widgets/book_items_shimmer.dart';
import 'package:ebook_reader/common/widgets/search_app_bar.dart';
import 'package:ebook_reader/common/widgets/top_app_bar.dart';
import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:ebook_reader/presentations/app_route.dart';
import 'package:ebook_reader/presentations/pages/home/providers/home_notifier.dart';
import 'package:ebook_reader/presentations/pages/home/providers/search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  Timer? _debounce;
  CancelToken? _cancelToken;

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
  void dispose() {
    _debounce?.cancel();
    _cancelToken?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.read(homeNotifierProvider.notifier);

    final searchProvider = ref.watch(searchNotifierProvider);
    final searchNotifier = ref.read(searchNotifierProvider.notifier);

    bool isFirstLoading = false;
    bool isError = false;

    final homeStateValue = homeState.maybeWhen<HomeState?>(
      orElse: () {
        return null;
      },
      data: (data) {
        isError = false;
        isFirstLoading = false;
        return data;
      },
      error: (error, stackTrace) {
        isError = true;
      },
      loading: () {
        isFirstLoading = true;
      },
    );

    final isLoadingMore = homeStateValue?.isLoadingMore ?? false;
    final allBooks = homeStateValue?.bookSet.books;

    final searchStateValue = searchProvider.maybeWhen<SearchState?>(
      orElse: () {
        return null;
      },
      data: (data) {
        return data;
      },
    );

    final isSearchActive = searchStateValue?.isSearchActive ?? false;
    final isSearching = searchStateValue?.isSearching ?? false;
    final searchedBooks = searchStateValue?.searchedBookSet?.books;

    final currentBooks = isSearchActive
        ? ((searchedBooks != null && searchedBooks.isNotEmpty)
            ? searchedBooks
            : allBooks)
        : allBooks;

    return Scaffold(
      appBar: !isSearchActive
          ? TopAppBar(
              headerTitle: "All books",
              iconRes: Assets.drawable.icSearch,
              onSearchPressed: () {
                searchNotifier.changeSearchActiveState(true);
              },
            )
          : SearchAppBar(
              onCloseIconClicked: () {
                searchNotifier.changeSearchActiveState(false);
              },
              onInputValueChange: (value) {
                searchNotifier.changeSearchingState(true);
                _cancelToken?.cancel();
                _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _cancelToken = CancelToken();
                  searchNotifier.searchBooks(
                      _cancelToken!, value);
                });
              },
            ),
      body: Container(
        child: isFirstLoading
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const BookItemsShimmer(),
              )
            : isError
                ? Center(
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
                  )
                : (currentBooks != null && currentBooks.isNotEmpty)
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: !isSearching
                            ? ListView.builder(
                                controller: _scrollController(ref),
                                padding: const EdgeInsets.all(4.0),
                                itemCount: currentBooks.length +
                                    (isLoadingMore ? 1 : 0),
                                itemBuilder: (_, index) {
                                  if (index < currentBooks.length) {
                                    return BookItemCard(
                                      title: currentBooks[index].title,
                                      author: currentBooks[index]
                                              .authors
                                              .isNotEmpty
                                          ? currentBooks[index].authors[0].name
                                          : "",
                                      language: currentBooks[index]
                                              .languages
                                              .isNotEmpty
                                          ? currentBooks[index].languages[0]
                                          : "",
                                      subjects: currentBooks[index]
                                              .subjects
                                              .isNotEmpty
                                          ? currentBooks[index].subjects[0]
                                          : "",
                                      coverImageUrl:
                                          currentBooks[index].formats.imageJpeg,
                                      onClick: () => {
                                        GoRouter.of(context).push(
                                          AppRoute.bookDetail.path,
                                          extra: {
                                            'bookId': currentBooks[index].id,
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
                              )
                            : const Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.0),
                                  child: LinearProgressIndicator(),
                                ),
                              ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: const BookItemsShimmer(),
                      ),
      ),
    );
  }
}
