import 'package:dio/dio.dart';

class ApiService {
  static late Dio dio;

  static initDio() {
    dio = Dio();
  }

  static Future<Map<String, dynamic>> getData(
      {required String url,
      dynamic query,
      String token = '',
      String lang = 'en'}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    var response = await dio.get(
      url,
      queryParameters: query,
    );
    return response.data;
  }

  static Future<Response> postData({
    required String url,
    dynamic query,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    String token = '',
    String contentType = 'application/json',
    bool isPayment = false,
  }) async {
    dio.options.headers = headers ??{
      'lang': 'en',
      'Authorization': isPayment ? 'Bearer $token' : token,
      'Content-Type': contentType,
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    required String token,
  }) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    return await dio.put(
      url,
      data: data,
    );
  }

  static Future<Map<String, dynamic>> deleteData(
      {required String url,
      dynamic query,
      String token = '',
      String lang = 'en'}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    var response = await dio.delete(
      url,
      queryParameters: query,
    );
    return response.data;
  }
}
