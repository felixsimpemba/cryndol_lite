import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
  
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String message;
  
  const ServerFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  final String message;
  
  const CacheFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  final String message;
  
  const NetworkFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}

// Authentication failures
class AuthenticationFailure extends Failure {
  final String message;
  
  const AuthenticationFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}

class InvalidCredentialsFailure extends Failure {
  final String message;
  
  const InvalidCredentialsFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}

// Loan management failures
class LoanNotFoundFailure extends Failure {
  final String message;
  
  const LoanNotFoundFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}

class PaymentNotFoundFailure extends Failure {
  final String message;
  
  const PaymentNotFoundFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}

class ValidationFailure extends Failure {
  final String message;
  
  const ValidationFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}

// Database failures
class DatabaseFailure extends Failure {
  final String message;
  
  const DatabaseFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}

// Permission failures
class PermissionFailure extends Failure {
  final String message;
  
  const PermissionFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}
