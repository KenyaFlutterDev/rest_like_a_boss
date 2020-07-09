import 'package:dio/dio.dart';

class CustomCacheInterceptor extends Interceptor{
  @override
  Future onRequest(RequestOptions options) {
    // TODO: check of data exists in cache and responds
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    // TODO: store the cached response
    return super.onResponse(response);
  }
}