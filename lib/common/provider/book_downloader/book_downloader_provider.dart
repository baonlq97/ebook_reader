import 'package:dio/dio.dart';
import 'package:ebook_reader/common/helper/book/book_downloader.dart';
import 'package:ebook_reader/di/providers/dio/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_downloader_provider.g.dart';

@riverpod
BookDownloader bookDownloader(BookDownloaderRef ref) {
  Dio dio = ref.read(dioProvider);
  return BookDownloader(dio: dio);
}