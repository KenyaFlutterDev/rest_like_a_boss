import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:resty/utils/interceptors/auth_interceptor.dart';
import 'package:resty/utils/interceptors/custom_cache_interceptor.dart';
import 'package:resty/utils/interceptors/error_interceptor.dart';

class RestClient {
  Dio _dio;

  Dio get dio => _dio;

  RestClient({BaseOptions options}) {
    create(options);
  }

  create([BaseOptions options]) {
    _dio = Dio(options);
    _dio.interceptors
      ..add(AuthInterceptor())
      ..add(ErrorInterceptor())
      ..add(CustomCacheInterceptor())
      ..add(DioCacheManager(CacheConfig()).interceptor);
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }
    return _dio;
  }
}
