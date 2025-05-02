import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news/api/api_const.dart';
import 'package:news/helper/environment.dart';

class VPSDio {
  static late Dio _dio;

  /// Initialize Dio with default configuration
  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  /// GET request
  static Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final updatedQueryParameters = {
        'apiKey': Enviroment.apiKey,
        if (queryParameters != null) ...queryParameters,
      };

      return await _dio.get(
        path,
        queryParameters: updatedQueryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handle Dio Errors
  static Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception(
          'Connection timeout. Please check your internet connection.',
        );

      case DioExceptionType.sendTimeout:
        return Exception('Send timeout. Please try again.');

      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout. Please try again.');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;

        switch (statusCode) {
          case 400:
            return Exception(
              'Bad request: ${data?['message'] ?? 'Unknown error'}',
            );
          case 401:
            return Exception(
              'Unauthorized: ${data?['message'] ?? 'Please login again'}',
            );
          case 403:
            return Exception(
              'Forbidden: ${data?['message'] ?? 'Access denied'}',
            );
          case 404:
            return Exception(
              'Not found: ${data?['message'] ?? 'Resource not found'}',
            );
          case 422:
            return Exception(
              'Validation error: ${data?['message'] ?? 'Invalid data'}',
            );
          default:
            return Exception(
              'Server error: ${data?['message'] ?? 'Unknown error'}',
            );
        }

      case DioExceptionType.cancel:
        return Exception('Request cancelled');

      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return Exception('No internet connection');
        }
        return Exception('Network error occurred: ${e.message}');

      default:
        return Exception('Something went wrong: ${e.message}');
    }
  }
}
