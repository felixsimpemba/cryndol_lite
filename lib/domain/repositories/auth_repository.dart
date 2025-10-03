import '../../data/models/api_response.dart';
import '../../data/models/token_model.dart';
import '../../data/models/business_profile_model.dart';

abstract class AuthRepository {
  Future<ApiResponse<Map<String, dynamic>>> registerPersonal({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required bool acceptTerms,
  });

  Future<ApiResponse<Map<String, dynamic>>> login({
    required String email,
    required String password,
  });

  Future<ApiResponse<TokenModel>> refreshToken({
    required String refreshToken,
  });

  Future<ApiResponse<Map<String, dynamic>>> logout({
    required String token,
  });

  Future<ApiResponse<Map<String, dynamic>>> getUserProfile({
    required String token,
  });

  Future<ApiResponse<BusinessProfileModel>> createBusinessProfile({
    required String token,
    required String businessName,
  });

  Future<ApiResponse<BusinessProfileModel>> updateBusinessProfile({
    required String token,
    required String businessName,
  });

  Future<ApiResponse<Map<String, dynamic>>> deleteBusinessProfile({
    required String token,
  });
}
