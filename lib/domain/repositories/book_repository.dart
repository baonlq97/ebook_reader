import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ebook_reader/common/resources/data_state.dart';
import 'package:ebook_reader/data/data_source/remote/book_api_service.dart';
import 'package:ebook_reader/domain/models/book/book.dart';
import 'package:ebook_reader/domain/models/book_set/book_set.dart';

class BookRepository {
  final BookApiService apiService;

  BookRepository({required this.apiService});

  Future<DataState<BookSet>> getAllBooks(int page) async {
    try {
      final httpResponse = await apiService.getAllBooks(page: page);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }

  Future<DataState<BookSet>> getBookDetail(int bookId) async {
    try {
      final httpResponse = await apiService.getBookDetail(bookId: bookId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }
}
