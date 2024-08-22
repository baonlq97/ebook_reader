import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ebook_reader/common/helper/book/book_downloader.dart';
import 'package:ebook_reader/common/provider/book_downloader/book_downloader_provider.dart';
import 'package:ebook_reader/common/resources/data_state.dart';
import 'package:ebook_reader/data/models/api/book/book.dart';
import 'package:ebook_reader/data/models/api/book_set/book_set.dart';
import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:ebook_reader/di/providers/book_repository/book_repository_provider.dart';

part 'book_detail_notifier.g.dart';

class BookDetailPageState {
  final BookSet? bookSet;
  final double downloadProgress;
  final LibraryItem? libraryItem;
  final AsyncValue<void> insertState;

  BookDetailPageState({
    this.bookSet,
    this.downloadProgress = 0,
    this.libraryItem,
    this.insertState = const AsyncData(null),
  });

  BookDetailPageState copyWith({
    BookSet? bookSet,
    double? downloadProgress,
    LibraryItem? libraryItem,
    AsyncValue<void>? insertState,
  }) {
    return BookDetailPageState(
      bookSet: bookSet ?? this.bookSet,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      libraryItem: libraryItem ?? this.libraryItem,
      insertState: insertState ?? this.insertState,
    );
  }
}

@riverpod
class BookDetail extends _$BookDetail {
  @override
  Future<BookDetailPageState?> build() async {
    return BookDetailPageState();
  }

  Future<void> getBookDetail(int bookId) async {
    // state = const AsyncLoading();
    final repository = ref.read(bookRepositoryProvider);
    final dataState = await repository.getBookDetail(bookId);

    if (dataState is DataSuccess && dataState.data != null) {
      state = AsyncData(state.value!.copyWith(
        bookSet: dataState.data!,
      ));
    } else if (dataState is DataFailed) {
      state = AsyncError(dataState.error!, dataState.error!.stackTrace);
    }
  }

  Future<void> insert(LibraryItem item) async {
    // state = const AsyncLoading();
    final repository = ref.read(bookRepositoryProvider);
    await repository.insert(item);
    state = AsyncData(state.value!.copyWith(libraryItem: item));
  }

  Future<void> getBookById(int bookId) async {
    final repository = ref.read(bookRepositoryProvider);
    final libraryItem = await repository.getItemById(bookId);
    state = AsyncData(state.value?.copyWith(libraryItem: libraryItem));
  }

  Future<void> startDownloading(
    BuildContext context,
    Book book,
    Function(String) onSuccess,
  ) async {
    final bookDownloader = ref.read(bookDownloaderProvider);
    await bookDownloader.startDownloading(
      context,
      book,
      (receivedBytes, totalBytes) {
        final downloadProgress =
            (totalBytes > 0 ? receivedBytes / totalBytes : 0).toDouble();
        state = AsyncData(
            state.value?.copyWith(downloadProgress: downloadProgress));
      },
      onSuccess,
    );
  }
}