import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err) {
    switch (err.type) {
      case DioErrorType.RESPONSE:
        if (err.response.data != null) {
          if (err.response.data['message'] != null) {
            err.error = err.response.data['message'];
          }
        }
        if (err.response.statusCode == 404) {
          err.error = 'Page not found';
        }
        break;
      default:
        break;
    }
    return super.onError(err);
  }
}
