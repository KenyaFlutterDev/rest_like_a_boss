import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:resty/utils/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  static Future<void> login(Map<String, dynamic> credentials)async{
    Response res = await GetIt.I<RestClient>().dio.post(
      //TODO: Remember to change the IP to match your PC's
      'http://192.168.100.104:3000/auth/login',
      data: credentials,
    );
    var token = res.data['access_token'];
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}