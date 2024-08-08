import 'package:ebook_reader/common/helper/book/book_downloader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_downloader_provider.g.dart';

@riverpod
BookDownloader bookDownloader(BookDownloaderRef ref) {
  return BookDownloader();
}