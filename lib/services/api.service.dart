import 'dart:developer';

import 'package:dio/dio.dart';

class APIClient {
  String baseURL = "https://be-casual-mongo-db.vercel.app/api/v1/";
  String endpoint = "";
  Dio dio = Dio();

  APIClient(this.endpoint) {
    dio = Dio(BaseOptions(
      baseUrl: baseURL,
      headers: {
        'Content-Type': 'application/json',
      },
      responseType: ResponseType.json,
    ));
  }


  Future<Response?> get({String? id}) async {
    try {
      String url = id != null ? '$endpoint/$id' : endpoint;
      final response = await dio.get(url);
      return response;
    } catch (e) {
      log("API Error: $e");
      return null;
    }
  }

  Future<Response?> post(dynamic data) async {
    return await dio.post(endpoint, data: data);
  }

  Future<Response?> put(dynamic data, {String? id}) async {
    try {
      String url = id != null ? '$endpoint/$id' : endpoint;
      final response = await dio.put(url, data: data);
      return response;
    } catch (e) {
      log("API PUT Error: $e");
      return null;
    }
  }
}
