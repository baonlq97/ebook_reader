import 'package:ebook_reader/common/resources/data_state.dart';
import 'package:ebook_reader/di/providers/book_repository/book_repository_provider.dart';
import 'package:ebook_reader/domain/models/book_set/book_set.dart';
import 'package:ebook_reader/domain/repositories/book_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

@riverpod
Future<BookSet?> getAllBooks(GetAllBooksRef ref) async {
  final repository = ref.watch(bookRepositoryProvider);
  final dataState = await repository.getAllBooks(1);

  BookSet? data;

  if (dataState is DataSuccess && dataState.data != null) {
    data = dataState.data!;
  }

  if (dataState is DataFailed) {
    throw dataState.error!;
  }

  return data;
}
