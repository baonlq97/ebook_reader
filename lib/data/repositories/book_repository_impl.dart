import 'dart:io';

import 'package:dio/dio.dart';

import 'package:ebook_reader/common/resources/data_state.dart';
import 'package:ebook_reader/data/data_source/local/book_db_service.dart';
import 'package:ebook_reader/data/data_source/remote/book_api_service.dart';
import 'package:ebook_reader/data/models/api/book_set/book_set.dart';
import 'package:ebook_reader/data/models/database/library_item.dart';

abstract class BookRepository {
  Future<DataState<BookSet>> getAllBooks(int page);
  Future<DataState<BookSet>> getBookDetail(int bookId);
  Future<void> insert(LibraryItem item);
  Future<LibraryItem?> getItemById(int bookId);
  Future<List<LibraryItem?>> getAllItems();
  Future<void> delete(LibraryItem item);
}

class BookRepositoryImpl implements BookRepository {
  final BookApiService apiService;
  final BookDbService dbService;

  BookRepositoryImpl({
    required this.apiService,
    required this.dbService,
  });

  @override
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

  @override
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
  
  @override
  Future<void> insert(LibraryItem item) async {
    try {
      await dbService.insert(item);
    }
    catch (ex) {
      throw ex;
    }
  }
  
  @override
  Future<LibraryItem?> getItemById(int bookId) async {
    try {
      return await dbService.getItemById(bookId);
    }
    catch (ex) {
      throw ex;
    }
  }
  
  @override
  Future<List<LibraryItem?>> getAllItems() async {
    try {
      return await dbService.getAllItems();
    }
    catch (ex) {
      throw ex;
    }
  }
  
  @override
  Future<void> delete(LibraryItem item) async {
    try {
      await dbService.delete(item);
    }
    catch (ex) {
      throw ex;
    }
  }
}
