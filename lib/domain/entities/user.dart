import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String? email;
  final String? phoneNumber;
  final String? profileImagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isBiometricEnabled;
  
  const User({
    required this.id,
    required this.name,
    this.email,
    this.phoneNumber,
    this.profileImagePath,
    required this.createdAt,
    required this.updatedAt,
    this.isBiometricEnabled = false,
  });
  
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isBiometricEnabled,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
    );
  }
  
  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        profileImagePath,
        createdAt,
        updatedAt,
        isBiometricEnabled,
      ];
}
