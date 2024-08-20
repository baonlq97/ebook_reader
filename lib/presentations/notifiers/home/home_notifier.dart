import 'package:ebook_reader/common/resources/data_state.dart';
import 'package:ebook_reader/di/providers/book_repository/book_repository_provider.dart';
import 'package:ebook_reader/data/models/api/book_set/book_set.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

class HomeState {
  final BookSet bookSet;
  final bool isLoadingMore;

  HomeState({
    required this.bookSet,
    this.isLoadingMore = false,
  });
}

@riverpod
class HomeNotifier extends _$HomeNotifier {
  int currentPage = 1;
  bool hasMore = true;
  bool isLoadingMore = false;

  @override
  Future<HomeState> build() async {
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
      throw dataState.error!;
    }

    return data!;
  }
}

// @riverpod
// Future<BookSet?> getAllBooks(GetAllBooksRef ref, int page) async {
//   final repository = ref.watch(bookRepositoryProvider);
//   final dataState = await repository.getAllBooks(page);

//   BookSet? data;

//   if (dataState is DataSuccess && dataState.data != null) {
//     data = dataState.data!;
//   }

//   if (dataState is DataFailed) {
//     throw dataState.error!;
//   }

//   return data;
// }
