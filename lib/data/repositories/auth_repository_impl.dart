import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/api_response.dart';
import '../models/user_model.dart';
import '../models/token_model.dart';
import '../models/business_profile_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl({AuthRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? AuthRemoteDataSource();

  @override
  Future<ApiResponse<Map<String, dynamic>>> registerPersonal({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required bool acceptTerms,
  }) async {
    return await _remoteDataSource.registerPersonal(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      acceptTerms: acceptTerms,
    );
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    return await _remoteDataSource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<ApiResponse<TokenModel>> refreshToken({
    required String refreshToken,
  }) async {
    return await _remoteDataSource.refreshToken(
      refreshToken: refreshToken,
    );
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> logout({
    required String token,
  }) async {
    return await _remoteDataSource.logout(
      token: token,
    );
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> getUserProfile({
    required String token,
  }) async {
    return await _remoteDataSource.getUserProfile(
      token: token,
    );
  }

  @override
  Future<ApiResponse<BusinessProfileModel>> createBusinessProfile({
    required String token,
    required String businessName,
  }) async {
    return await _remoteDataSource.createBusinessProfile(
      token: token,
      businessName: businessName,
    );
  }

  @override
  Future<ApiResponse<BusinessProfileModel>> updateBusinessProfile({
    required String token,
    required String businessName,
  }) async {
    return await _remoteDataSource.updateBusinessProfile(
      token: token,
      businessName: businessName,
    );
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> deleteBusinessProfile({
    required String token,
  }) async {
    return await _remoteDataSource.deleteBusinessProfile(
      token: token,
    );
  }
}
