import 'package:ebook_reader/data/data_source/remote/book_api_service.dart';
import 'package:ebook_reader/di/providers/dio/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_api_service_provider.g.dart';

@riverpod
BookApiService bookApiService (BookApiServiceRef ref) {
  final dio = ref.watch(dioProvider);
  return BookApiService(dio);
}