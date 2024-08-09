import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:isar/isar.dart';

class BookDbService {
  final Isar isarDB;

  BookDbService({
    required this.isarDB,
  });

  Future<void> insert(LibraryItem item) async {
    await isarDB.writeTxn(
      () async {
        await isarDB.libraryItems.put(item);
      },
    );
  }

  Future<LibraryItem?> getItemById(int bookId) async {
    final item =
        isarDB.libraryItems.filter().bookIdEqualTo(bookId).findFirst();
    return item;
  }
}
