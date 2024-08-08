
import 'package:dio/dio.dart';
import 'package:ebook_reader/common/constant/constant.dart';
import 'package:ebook_reader/domain/models/book/book.dart';
import 'package:ebook_reader/domain/models/book_set/book_set.dart';
import 'package:retrofit/retrofit.dart';
part 'book_api_service.g.dart';

@RestApi(baseUrl: baseApiUrl)
abstract class BookApiService {
  factory BookApiService(Dio dio) = _BookApiService;

  @GET("/books")
  Future<HttpResponse<BookSet>> getAllBooks({
    @Query('page') required int page,
  });

  @GET("/books")
  Future<HttpResponse<BookSet>> getBookDetail({
    @Query('ids') required int bookId,
  });
}