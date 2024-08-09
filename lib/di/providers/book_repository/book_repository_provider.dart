import 'package:ebook_reader/data/data_source/local/book_db_service.dart';
import 'package:ebook_reader/data/data_source/remote/book_api_service.dart';
import 'package:ebook_reader/data/repositories/book_repository_impl.dart';
import 'package:ebook_reader/di/providers/book_api_service/book_api_service_provider.dart';
import 'package:ebook_reader/di/providers/book_db_service/book_db_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_repository_provider.g.dart';

@riverpod
BookRepository bookRepository(BookRepositoryRef ref) {
  BookApiService apiService = ref.watch(bookApiServiceProvider);
  BookDbService dbService = ref.watch(bookDBServiceProvider);
  return BookRepositoryImpl(
    apiService: apiService,
    dbService: dbService,
  );
}
