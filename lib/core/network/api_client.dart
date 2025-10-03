import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/api_response.dart';
import '../config/api_config.dart';

class ApiClient {
  static  String baseUrl = ApiConfig.baseUrl;
  static const Duration timeout = ApiConfig.requestTimeout;

  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Map<String, String> _getHeaders({String? token}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    String? token,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _client
          .get(
            Uri.parse('$baseUrl$endpoint'),
            headers: _getHeaders(token: token),
          )
          .timeout(timeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final url = '$baseUrl$endpoint';
      final headers = _getHeaders(token: token);
      final requestBody = body != null ? json.encode(body) : null;
      
      print('POST Request to: $url');
      print('Headers: $headers');
      print('Body: $requestBody');
      
      final response = await _client
          .post(
            Uri.parse(url),
            headers: headers,
            body: requestBody,
          )
          .timeout(timeout);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      print('POST Request Error: $e');
      return ApiResponse<T>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _client
          .put(
            Uri.parse('$baseUrl$endpoint'),
            headers: _getHeaders(token: token),
            body: body != null ? json.encode(body) : null,
          )
          .timeout(timeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    String? token,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _client
          .delete(
            Uri.parse('$baseUrl$endpoint'),
            headers: _getHeaders(token: token),
          )
          .timeout(timeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  ApiResponse<T> _handleResponse<T>(
    http.Response response,
    T Function(dynamic)? fromJson,
  ) {
    try {
      final jsonData = json.decode(response.body);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse<T>.fromJson(jsonData, fromJson);
      } else {
        return ApiResponse<T>(
          success: false,
          message: jsonData['message'] ?? 'Request failed',
          errors: jsonData['errors'],
        );
      }
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        message: 'Failed to parse response: ${e.toString()}',
      );
    }
  }

  void dispose() {
    _client.close();
  }
}
