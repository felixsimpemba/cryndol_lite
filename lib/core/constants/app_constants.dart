class AppConstants {
  // App Information
  static const String appName = 'Cryndol Lite';
  static const String appVersion = '1.0.0';
  
  // Database
  static const String databaseName = 'loan_management.db';
  static const int databaseVersion = 1;
  
  // Storage Keys
  static const String isFirstTimeKey = 'is_first_time';
  static const String userPinKey = 'user_pin';
  static const String biometricEnabledKey = 'biometric_enabled';
  static const String darkModeKey = 'dark_mode';
  static const String currencyKey = 'default_currency';
  
  // Authentication Keys
  static const String userKey = 'user_authenticated';
  static const String userEmailKey = 'user_email';
  static const String userFullNameKey = 'user_full_name';
  static const String userPhoneKey = 'user_phone';
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  
  // Business Profile Keys
  static const String businessNameKey = 'business_name';
  static const String businessProfileSkippedKey = 'business_profile_skipped';
  
  // Loan Types
  static const List<String> loanTypes = [
    'Personal',
    'Mortgage',
    'Auto',
    'Student',
    'Business',
  ];
  
  // Payment Frequencies
  static const List<String> paymentFrequencies = [
    'Weekly',
    'Bi-weekly',
    'Monthly',
    'Quarterly',
    'Yearly',
  ];
  
  // Payment Methods
  static const List<String> paymentMethods = [
    'Cash',
    'Bank Transfer',
    'Credit Card',
    'Debit Card',
    'Check',
    'Online Payment',
  ];
  
  // Payment Status
  static const String paymentPending = 'pending';
  static const String paymentCompleted = 'completed';
  static const String paymentMissed = 'missed';
  
  // Loan Status
  static const String loanActive = 'active';
  static const String loanCompleted = 'completed';
  static const String loanPending = 'pending';
  
  // Notification Intervals
  static const List<int> reminderDays = [1, 3, 7, 14];
  
  // Default Currency
  static const String defaultCurrency = 'USD';
  
  // Supported Currencies
  static const List<String> supportedCurrencies = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'CAD',
    'AUD',
    'INR',
  ];
}
