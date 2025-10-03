class ApiConfig {
  // API Base URLs
  static const String developmentBaseUrl = 'http://192.168.0.141:8000/api';
  static const String productionBaseUrl = 'https://api.cryndol.com/v1';
  
  // Current environment (change this to switch between dev and prod)
  static const bool isDevelopment = true;
  
  // Mock mode - set to true if API server is not running
  static const bool useMockMode = false;
  
  // Get the current base URL based on environment
  static String get baseUrl {
    return isDevelopment ? developmentBaseUrl : productionBaseUrl;
  }
  
  // API Endpoints
  static const String registerPersonalEndpoint = '/auth/register/personal';
  static const String loginEndpoint = '/auth/login';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String logoutEndpoint = '/auth/logout';
  static const String userProfileEndpoint = '/auth/profile';
  static const String businessProfileEndpoint = '/auth/business-profile';
  
  // Request timeouts
  static const Duration requestTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 15);
  
  // Retry configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);
}
