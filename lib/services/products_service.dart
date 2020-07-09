import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get_it/get_it.dart';
import 'package:resty/utils/rest_client.dart';

class ProductsService {
  static Future<List> fetchAll() async {
    Response res = await GetIt.I<RestClient>().dio.get(
          //TODO: Remember to change the IP to match your PC's
          'http://192.168.100.104:3000/products',
          options:
              buildCacheOptions(Duration(seconds: 120), forceRefresh: true),
        );
    return res.data;
  }
}
