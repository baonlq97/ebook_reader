import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio (DioRef ref) {
  final dio = Dio();

  // Add interceptors, headers, etc.
  // dio.interceptors.add(
  //   InterceptorsWrapper(
  //     onRequest: (options, handler) {
  //       options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
  //       return handler.next(options);
  //     },
  //     onResponse: (response, handler) {
  //       return handler.next(response);
  //     },
  //     onError: (DioException e, handler) {
  //       return handler.next(e);
  //     },
  //   ),
  // );

  return dio;
}