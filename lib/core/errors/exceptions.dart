class ServerException implements Exception {
  final String message;
  
  const ServerException({required this.message});
  
  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  final String message;
  
  const CacheException({required this.message});
  
  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;
  
  const NetworkException({required this.message});
  
  @override
  String toString() => 'NetworkException: $message';
}

class AuthenticationException implements Exception {
  final String message;
  
  const AuthenticationException({required this.message});
  
  @override
  String toString() => 'AuthenticationException: $message';
}

class InvalidCredentialsException implements Exception {
  final String message;
  
  const InvalidCredentialsException({required this.message});
  
  @override
  String toString() => 'InvalidCredentialsException: $message';
}

class LoanNotFoundException implements Exception {
  final String message;
  
  const LoanNotFoundException({required this.message});
  
  @override
  String toString() => 'LoanNotFoundException: $message';
}

class PaymentNotFoundException implements Exception {
  final String message;
  
  const PaymentNotFoundException({required this.message});
  
  @override
  String toString() => 'PaymentNotFoundException: $message';
}

class ValidationException implements Exception {
  final String message;
  
  const ValidationException({required this.message});
  
  @override
  String toString() => 'ValidationException: $message';
}

class DatabaseException implements Exception {
  final String message;
  
  const DatabaseException({required this.message});
  
  @override
  String toString() => 'DatabaseException: $message';
}

class PermissionException implements Exception {
  final String message;
  
  const PermissionException({required this.message});
  
  @override
  String toString() => 'PermissionException: $message';
}
