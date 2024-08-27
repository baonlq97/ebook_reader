import 'package:dio/dio.dart';
import 'package:ebook_reader/common/resources/data_state.dart';
import 'package:ebook_reader/data/models/api/author/author.dart';
import 'package:ebook_reader/data/models/api/book/book.dart';
import 'package:ebook_reader/di/providers/book_repository/book_repository_provider.dart';
import 'package:ebook_reader/data/models/api/book_set/book_set.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

class HomeState {
  final BookSet bookSet;
  final bool isLoadingMore;
  final bool isSearchActive;
  final bool isSearching;
  final BookSet? searchedBookSet;

  HomeState(
      {required this.bookSet,
      this.isLoadingMore = false,
      this.isSearchActive = false,
      this.isSearching = false,
      this.searchedBookSet});

  HomeState copyWith({
    BookSet? bookSet,
    bool? isLoadingMore,
    bool? isSearchActive,
    bool? isSearching,
    BookSet? searchedBookSet,
  }) {
    return HomeState(
      bookSet: bookSet ?? this.bookSet,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      isSearching: isSearching ?? this.isSearching,
      searchedBookSet: searchedBookSet ?? this.searchedBookSet,
    );
  }
}

@riverpod
class HomeNotifier extends _$HomeNotifier {
  int currentPage = 1;
  bool hasMore = true;
  bool isLoadingMore = false;

  @override
  Future<HomeState?> build() async {
    // Initial fetch
    state = const AsyncLoading();
    final bookSet = await _fetchBooks(currentPage);
    return HomeState(bookSet: bookSet);
  }

  Future<void> fetchMoreBooks() async {
    if (isLoadingMore || !hasMore) return;

    state = AsyncValue.data(HomeState(
      bookSet: state.value!.bookSet,
      isLoadingMore: true,
    ));

    try {
      final nextPage = currentPage + 1;
      final newBookSet = await _fetchBooks(nextPage);

      state = AsyncValue.data(
        HomeState(
            bookSet: BookSet(
              count: newBookSet.count,
              next: newBookSet.next,
              previous: newBookSet.previous,
              books: [
                ...state.value?.bookSet.books ?? [],
                ...newBookSet.books,
              ],
            ),
            isLoadingMore: false),
      );

      currentPage = nextPage;
      hasMore = newBookSet.books.isNotEmpty;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<BookSet> _fetchBooks(int page) async {
    final repository = ref.watch(bookRepositoryProvider);
    final dataState = await repository.getAllBooks(page);

    BookSet? data;

    if (dataState is DataSuccess && dataState.data != null) {
      data = dataState.data!;
    }

    if (dataState is DataFailed) {
      Logger(filter: ProductionFilter()).e('Error', error: dataState.error);
      throw dataState.error!;
    }

    return data!;
  }
}
