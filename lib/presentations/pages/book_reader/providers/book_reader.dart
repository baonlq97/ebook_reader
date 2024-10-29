import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:ebook_reader/di/providers/book_repository/book_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_reader.g.dart';

@riverpod
class BookReader extends _$BookReader {
  Future<void> saveCurrentPosition(LibraryItem item) async {
    final repository = ref.watch(bookRepositoryProvider);
    await repository.insert(item);
  }

  @override
  void build() => {};
}
