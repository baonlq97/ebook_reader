import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_reader.g.dart';

@riverpod
class BookReader extends _$BookReader {
  @override
  int build() {
    return 0;
  }

  void setCurrentIndex(int index) {
    state = index;
  }
}