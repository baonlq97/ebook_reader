import 'package:dio/dio.dart';
import 'package:ebook_reader/common/resources/data_state.dart';
import 'package:ebook_reader/data/models/api/book_set/book_set.dart';
import 'package:ebook_reader/di/providers/book_repository/book_repository_provider.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_notifier.g.dart';

class SearchState {
  final bool isSearchActive;
  final bool isSearching;
  final BookSet? searchedBookSet;

  SearchState(
      {this.isSearchActive = false,
      this.isSearching = false,
      this.searchedBookSet});

  SearchState copyWith({
    BookSet? bookSet,
    bool? isLoadingMore,
    bool? isSearchActive,
    bool? isSearching,
    BookSet? searchedBookSet,
  }) {
    return SearchState(
      isSearchActive: isSearchActive ?? this.isSearchActive,
      isSearching: isSearching ?? this.isSearching,
      searchedBookSet: searchedBookSet ?? this.searchedBookSet,
    );
  }
}


@riverpod
class SearchNotifier extends _$SearchNotifier {
  @override
  Future<SearchState?> build() async {
    return SearchState();
  }

  Future<void> changeSearchActiveState(bool isActive) async {
    state = AsyncData(
      state.value?.copyWith(isSearchActive: isActive),
    );
  }

  Future<void> changeSearchingState(bool isSearching) async {
    state = AsyncData(state.value?.copyWith(isSearching: isSearching));
  }

  Future<void> searchBooks(CancelToken cancelToken, String query) async {
    final repository = ref.watch(bookRepositoryProvider);
    final dataState = await repository.searchBooks(cancelToken, query);

    BookSet? data;

    if (dataState is DataSuccess && dataState.data != null) {
      data = dataState.data!;
    }

    if (dataState is DataFailed) {
      if (dataState.error!.type == DioExceptionType.cancel) {
        return;
      }
      Logger(filter: ProductionFilter()).e('Error', error: dataState.error);
      throw dataState.error!;
    }

    state = AsyncData(state.value?.copyWith(
      searchedBookSet: data,
      isSearching: false,
    ));
  }
}