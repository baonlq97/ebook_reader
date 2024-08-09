import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'library_item_db.g.dart';

@riverpod
Future<Isar> libraryItemDB(LibraryItemDBRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [LibraryItemSchema],
    directory: dir.path,
  );
  return isar;
}
