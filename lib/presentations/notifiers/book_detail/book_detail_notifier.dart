import 'package:ebook_reader/common/helper/book/book_downloader.dart';
import 'package:ebook_reader/common/provider/book_downloader/book_downloader_provider.dart';
import 'package:ebook_reader/common/resources/data_state.dart';
import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:ebook_reader/di/providers/book_repository/book_repository_provider.dart';
import 'package:ebook_reader/data/models/api/book/book.dart';
import 'package:ebook_reader/data/models/api/book_set/book_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_detail_notifier.g.dart';

@riverpod
Future<BookSet?> getBookDetail(GetBookDetailRef ref, int bookId) async {
  final repository = ref.watch(bookRepositoryProvider);
  final dataState = await repository.getBookDetail(bookId);

  BookSet? data;

  if (dataState is DataSuccess && dataState.data != null) {
    data = dataState.data!;
  }

  if (dataState is DataFailed) {
    throw dataState.error!;
  }

  return data;
}

@riverpod
class InsertItem extends _$InsertItem {
  @override
  Future<void> build() async {}

  Future<void> insert(LibraryItem item) async {
    state = const AsyncLoading();
    final repository = ref.read(bookRepositoryProvider);
    await repository.insert(item);
    state = const AsyncData(null);
  }
}

@riverpod
Future<LibraryItem?> getBookById (GetBookByIdRef ref, int bookId) async {
  final repository = ref.read(bookRepositoryProvider);
  return await repository.getItemById(bookId);
}

@riverpod
class DownloadNotifier extends _$DownloadNotifier {
  @override
  double build() {
    return 0;
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
        state = totalBytes > 0 ? receivedBytes / totalBytes : 0;
      },
      onSuccess,
    );
  }
}
