import 'package:cryndol_lite/data/models/api_response.dart';
import 'package:cryndol_lite/data/models/business_profile_model.dart';
import 'package:cryndol_lite/data/models/token_model.dart';

import '../../../core/network/api_client.dart';


class AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSource({ApiClient? apiClient}) 
      : _apiClient = apiClient ?? ApiClient();

  Future<ApiResponse<Map<String, dynamic>>> registerPersonal({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required bool acceptTerms,
  }) async {
    return await _apiClient.post<Map<String, dynamic>>(
      '/auth/register/personal',
      body: {
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'acceptTerms': acceptTerms,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    return await _apiClient.post<Map<String, dynamic>>(
      '/auth/login',
      body: {
        'email': email,
        'password': password,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }

  Future<ApiResponse<TokenModel>> refreshToken({
    required String refreshToken,
  }) async {
    return await _apiClient.post<TokenModel>(
      '/auth/refresh',
      body: {
        'refreshToken': refreshToken,
      },
      fromJson: (data) => TokenModel.fromJson(data),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> logout({
    required String token,
  }) async {
    return await _apiClient.post<Map<String, dynamic>>(
      '/auth/logout',
      token: token,
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getUserProfile({
    required String token,
  }) async {
    return await _apiClient.get<Map<String, dynamic>>(
      '/auth/profile',
      token: token,
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }

  Future<ApiResponse<BusinessProfileModel>> createBusinessProfile({
    required String token,
    required String businessName,
  }) async {
    return await _apiClient.post<BusinessProfileModel>(
      '/auth/business-profile',
      token: token,
      body: {
        'businessName': businessName,
      },
      fromJson: (data) => BusinessProfileModel.fromJson(data),
    );
  }

  Future<ApiResponse<BusinessProfileModel>> updateBusinessProfile({
    required String token,
    required String businessName,
  }) async {
    return await _apiClient.put<BusinessProfileModel>(
      '/auth/business-profile',
      token: token,
      body: {
        'businessName': businessName,
      },
      fromJson: (data) => BusinessProfileModel.fromJson(data),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> deleteBusinessProfile({
    required String token,
  }) async {
    return await _apiClient.delete<Map<String, dynamic>>(
      '/auth/business-profile',
      token: token,
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }
}
