import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    super.email,
    super.phoneNumber,
    super.profileImagePath,
    required super.createdAt,
    required super.updatedAt,
    super.isBiometricEnabled,
    this.hasBusinessProfile = false,
  });

  final bool hasBusinessProfile;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['fullName'] ?? '',
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      hasBusinessProfile: json['hasBusinessProfile'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'hasBusinessProfile': hasBusinessProfile,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserModel.fromEntity(User user, {bool hasBusinessProfile = false}) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      profileImagePath: user.profileImagePath,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
      isBiometricEnabled: user.isBiometricEnabled,
      hasBusinessProfile: hasBusinessProfile,
    );
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      profileImagePath: profileImagePath,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isBiometricEnabled: isBiometricEnabled,
    );
  }
}
