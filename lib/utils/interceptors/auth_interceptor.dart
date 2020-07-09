import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    if (!options.path.contains('/login')) {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${token ?? ''}';
    }
    return super.onRequest(options);
  }
}
