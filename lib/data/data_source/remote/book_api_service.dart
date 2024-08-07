
import 'package:dio/dio.dart';
import 'package:ebook_reader/common/constant/constant.dart';
import 'package:ebook_reader/di/providers/dio/dio_provider.dart';
import 'package:ebook_reader/domain/models/book_set/book_set.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'book_api_service.g.dart';

@RestApi(baseUrl: baseApiUrl)
abstract class BookApiService {
  factory BookApiService(Dio dio) = _BookApiService;

  @GET("/books")
  Future<HttpResponse<BookSet>> getAllBooks({
    @Query('page') required int page,
  });
}