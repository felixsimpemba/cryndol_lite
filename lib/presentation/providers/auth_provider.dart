import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../core/config/api_config.dart';
import '../../domain/entities/user.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/models/user_model.dart';
import '../../data/models/token_model.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider with ChangeNotifier {
  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _errorMessage;
  TokenModel? _tokens;
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();

  AuthStatus get status => _status;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated && _user != null;
  bool get isLoading => _status == AuthStatus.loading;

  Future<void> initializeAuth() async {
    _status = AuthStatus.loading;

    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString(AppConstants.userKey);
      final accessToken = prefs.getString(AppConstants.accessTokenKey);
      final refreshToken = prefs.getString(AppConstants.refreshTokenKey);
      
      if (userData != null && accessToken != null && refreshToken != null) {
        // Try to get user profile from API to validate token
        _tokens = TokenModel(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresIn: 3600,
        );

        try {
          final response = await _authRepository.getUserProfile(
            token: accessToken,
          );

          if (response.success && response.data != null) {
            final userData = response.data!['user'] as Map<String, dynamic>;
            _user = UserModel.fromJson(userData).toEntity();
            _status = AuthStatus.authenticated;
          } else {
            // Token might be expired, try to refresh
            await _tryRefreshToken();
          }
        } catch (e) {
          // If API call fails, clear stored data and show login
          await _clearStoredAuth();
          _status = AuthStatus.unauthenticated;
        }
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Failed to initialize authentication';
    }
    
    // Only notify listeners after the build phase is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authRepository.login(
        email: email,
        password: password,
      );

      if (response.success && response.data != null) {
        // Extract user and tokens from response
        final userData = response.data!['user'] as Map<String, dynamic>;
        final tokensData = response.data!['tokens'] as Map<String, dynamic>;

        _user = UserModel.fromJson(userData).toEntity();
        _tokens = TokenModel.fromJson(tokensData);

        // Save tokens locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConstants.userKey, 'authenticated');
        await prefs.setString(AppConstants.accessTokenKey, _tokens!.accessToken);
        await prefs.setString(AppConstants.refreshTokenKey, _tokens!.refreshToken);

        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = AuthStatus.error;
        _errorMessage = response.message;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Login failed. Please try again.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUpPersonal({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authRepository.registerPersonal(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        acceptTerms: true,
      );

      if (response.success && response.data != null) {
        // Extract user and tokens from response
        final userData = response.data!['user'] as Map<String, dynamic>;
        final tokensData = response.data!['tokens'] as Map<String, dynamic>;

        _user = UserModel.fromJson(userData).toEntity();
        _tokens = TokenModel.fromJson(tokensData);

        // Save tokens locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConstants.userKey, 'authenticated');
        await prefs.setString(AppConstants.accessTokenKey, _tokens!.accessToken);
        await prefs.setString(AppConstants.refreshTokenKey, _tokens!.refreshToken);

        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = AuthStatus.error;
        _errorMessage = response.message;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Signup failed. Please try again.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> createBusinessProfile({
    required String businessName,
  }) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      if (ApiConfig.useMockMode) {
        // Mock mode - simulate API call
        print('Mock mode: Creating business profile with name: $businessName');
        await Future.delayed(const Duration(seconds: 1));
        
        // Save business data locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConstants.businessNameKey, businessName);
        await prefs.setBool(AppConstants.businessProfileSkippedKey, false);

        print('Mock: Business profile created successfully');
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      }

      if (_tokens == null) {
        _status = AuthStatus.error;
        _errorMessage = 'No authentication token available';
        notifyListeners();
        print('Error: No authentication token available');
        return false;
      }

      print('Creating business profile with name: $businessName');
      print('Using access token: ${_tokens!.accessToken.substring(0, 20)}...');

      final response = await _authRepository.createBusinessProfile(
        token: _tokens!.accessToken,
        businessName: businessName,
      );

      print('Business profile API response: success=${response.success}, message=${response.message}');
      
      if (response.success) {
        // Save business data locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConstants.businessNameKey, businessName);
        await prefs.setBool(AppConstants.businessProfileSkippedKey, false);

        print('Business profile created and saved locally');
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = AuthStatus.error;
        _errorMessage = response.message;
        print('Business profile creation failed: ${response.message}');
        if (response.errors != null) {
          print('API errors: ${response.errors}');
        }
        notifyListeners();
        return false;
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Failed to create business profile. Please try again.';
      print('Business profile creation error: $e');
      notifyListeners();
      return false;
    }
  }

  Future<void> skipBusinessProfile() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      // Just mark that business profile was skipped
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.businessProfileSkippedKey, true);

      _status = AuthStatus.authenticated;
      notifyListeners();
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Failed to complete setup. Please try again.';
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      // Call logout API if we have a token
      if (_tokens != null) {
        try {
          await _authRepository.logout(token: _tokens!.accessToken);
        } catch (e) {
          // Continue with local logout even if API call fails
          print('Logout API call failed: $e');
        }
      }

      // Clear local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.userKey);
      await prefs.remove(AppConstants.accessTokenKey);
      await prefs.remove(AppConstants.refreshTokenKey);
      await prefs.remove(AppConstants.businessNameKey);
      await prefs.remove(AppConstants.businessProfileSkippedKey);

      _user = null;
      _tokens = null;
      _errorMessage = null;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Logout failed';
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> _tryRefreshToken() async {
    if (_tokens?.refreshToken == null) {
      await _clearStoredAuth();
      _status = AuthStatus.unauthenticated;
      return;
    }

    try {
      final response = await _authRepository.refreshToken(
        refreshToken: _tokens!.refreshToken,
      );

      if (response.success && response.data != null) {
        _tokens = response.data!;
        
        // Save new tokens
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConstants.accessTokenKey, _tokens!.accessToken);
        await prefs.setString(AppConstants.refreshTokenKey, _tokens!.refreshToken);

        // Try to get user profile again
        final userResponse = await _authRepository.getUserProfile(
          token: _tokens!.accessToken,
        );

        if (userResponse.success && userResponse.data != null) {
          final userData = userResponse.data!['user'] as Map<String, dynamic>;
          _user = UserModel.fromJson(userData).toEntity();
          _status = AuthStatus.authenticated;
        } else {
          await _clearStoredAuth();
          _status = AuthStatus.unauthenticated;
        }
      } else {
        await _clearStoredAuth();
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      await _clearStoredAuth();
      _status = AuthStatus.unauthenticated;
    }
  }

  Future<void> _clearStoredAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.userKey);
    await prefs.remove(AppConstants.accessTokenKey);
    await prefs.remove(AppConstants.refreshTokenKey);
    await prefs.remove(AppConstants.businessNameKey);
    await prefs.remove(AppConstants.businessProfileSkippedKey);
    
    _user = null;
    _tokens = null;
  }
}
