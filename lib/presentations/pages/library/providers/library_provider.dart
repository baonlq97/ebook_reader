import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:ebook_reader/di/providers/book_repository/book_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'library_provider.g.dart';

@riverpod
class Library extends _$Library {
  @override
  Future<List<LibraryItem?>> build() async {
    return await _fetchAllItems();
  }

  Future<void> deleteItemFromDB(LibraryItem item) async {
    final repository = ref.watch(bookRepositoryProvider);
    await repository.delete(item);
    ref.invalidateSelf();
  }

  Future<List<LibraryItem?>> _fetchAllItems() async {
    final repository = ref.watch(bookRepositoryProvider);
    return await repository.getAllItems();
  }
}