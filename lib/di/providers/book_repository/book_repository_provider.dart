import 'package:ebook_reader/data/data_source/remote/book_api_service.dart';
import 'package:ebook_reader/di/providers/book_api_service/book_api_service_provider.dart';
import 'package:ebook_reader/domain/repositories/book_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_repository_provider.g.dart';

@riverpod
BookRepository bookRepository (BookRepositoryRef ref) {
  BookApiService apiService = ref.watch(bookApiServiceProvider);
  return BookRepository(apiService: apiService);
}