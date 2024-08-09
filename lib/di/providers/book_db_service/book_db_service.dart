import 'package:ebook_reader/data/data_source/local/book_db_service.dart';
import 'package:ebook_reader/di/providers/library_item_db/library_item_db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_db_service.g.dart';

@riverpod
BookDbService bookDBService (BookDBServiceRef ref) {
  final libraryItemDB = ref.watch(libraryItemDBProvider);
  return libraryItemDB.when(
    data: (isarDB) => BookDbService(isarDB: isarDB),
    loading: () => throw UnimplementedError(), // Handle the loading state if necessary
    error: (err, stack) => throw err, // Handle errors if necessary
  );
}