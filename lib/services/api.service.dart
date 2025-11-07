import 'dart:developer';

import 'package:dio/dio.dart';

class APIClient {
  String baseURL = "https://be-casual-mongo-db.vercel.app/api/v1/";
  String endpoint = "";
  late final Dio dio;

  APIClient(this.endpoint) {
    // Setup Dio with sensible timeouts and JSON headers
    dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        headers: {'Content-Type': 'application/json'},
        responseType: ResponseType.json,
        // Use Durations with Dio v5+
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
  }

  Future<Response?> get({String? id}) async {
    try {
      String url = id != null ? '$endpoint/$id' : endpoint;
      log("GET URL: $url");
      final response = await dio.get(url);
      return response;
    } on DioException catch (e, st) {
      // Log structured error for easier debugging (DNS, timeout, response status, etc.)
      log(
        'API Error (GET) - type: ${e.type}; message: ${e.message}; url: ${e.requestOptions.uri}',
        error: e.error,
        stackTrace: st,
      );
      return null;
    } catch (e, st) {
      log('API Error (GET) - unexpected: $e', error: e, stackTrace: st);
      return null;
    }
  }

  Future<Response?> post(dynamic data) async {
    try {
      log("POST URL: $endpoint");
      final response = await dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e, st) {
      log(
        'API Error (POST) - type: ${e.type}; message: ${e.message}; url: ${e.requestOptions.uri}',
        error: e.error,
        stackTrace: st,
      );
      return null;
    } catch (e, st) {
      log('API Error (POST) - unexpected: $e', error: e, stackTrace: st);
      return null;
    }
  }

  Future<Response?> put(dynamic data, {String? id}) async {
    try {
      String url = id != null ? '$endpoint/$id' : endpoint;
      final response = await dio.put(url, data: data);
      return response;
    } on DioException catch (e, st) {
      log(
        'API PUT Error - type: ${e.type}; message: ${e.message}; url: ${e.requestOptions.uri}',
        error: e.error,
        stackTrace: st,
      );
      return null;
    } catch (e, st) {
      log('API PUT Error - unexpected: $e', error: e, stackTrace: st);
      return null;
    }
  }
}
