import 'package:isar/isar.dart';

part 'library_item.g.dart';

@collection
@Name('book_library')
class LibraryItem {
  Id id;

  @Name('book_id')
  int bookId;

  String title;

  String authors;

  @Name('file_path')
  String filePath;

  @Name('is_external_book')
  bool isExternalBook;

  @Name('created_at')
  int createdAt;

  LibraryItem({
    this.id = Isar.autoIncrement,
    required this.bookId,
    required this.title,
    required this.authors,
    required this.filePath,
    this.isExternalBook = false,
    required this.createdAt,
  });
}
