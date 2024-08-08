import 'package:ebook_reader/common/resources/data_state.dart';
import 'package:ebook_reader/di/providers/book_repository/book_repository_provider.dart';
import 'package:ebook_reader/domain/models/book/book.dart';
import 'package:ebook_reader/domain/models/book_set/book_set.dart';
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
void insertIntoDB (InsertIntoDBRef ref) {
  
}