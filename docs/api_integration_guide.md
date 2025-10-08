# API Integration Guide

## Overview

This guide explains how to set up and use the API integration in the Cryndol Lite Flutter app.

## Prerequisites

1. **Backend API Server**: Make sure your Laravel API server is running on `http://localhost:8000`
2. **Flutter Dependencies**: The required packages are already included in `pubspec.yaml`

## API Configuration

### Base URL Configuration

The API base URL is configured in `lib/core/config/api_config.dart`:

```dart
class ApiConfig {
  static const String developmentBaseUrl = 'http://localhost:8000/api';
  static const String productionBaseUrl = 'https://api.cryndol.com/v1';
  static const bool isDevelopment = true; // Change to false for production
}
```

### Switching Environments

To switch between development and production:

1. **Development**: Set `isDevelopment = true` (default)
2. **Production**: Set `isDevelopment = false`

## API Services Architecture

The API integration follows a clean architecture pattern:

```
lib/
├── core/
│   ├── config/
│   │   └── api_config.dart          # API configuration
│   └── network/
│       └── api_client.dart          # HTTP client wrapper
├── data/
│   ├── data_sources/
│   │   └── auth_remote_data_source.dart  # API calls
│   ├── models/
│   │   ├── api_response.dart        # Generic API response
│   │   ├── user_model.dart          # User data model
│   │   ├── token_model.dart         # JWT tokens model
│   │   └── business_profile_model.dart
│   └── repositories/
│       └── auth_repository_impl.dart    # Repository implementation
├── domain/
│   └── repositories/
│       └── auth_repository.dart     # Repository interface
└── presentation/
    └── providers/
        └── auth_provider.dart       # State management
```

## Available API Endpoints

### Authentication Endpoints

1. **POST** `/auth/register/personal` - Register new user
2. **POST** `/auth/login` - User login
3. **POST** `/auth/refresh` - Refresh access token
4. **POST** `/auth/logout` - User logout
5. **GET** `/auth/profile` - Get user profile

### Business Profile Endpoints

1. **POST** `/auth/business-profile` - Create business profile
2. **PUT** `/auth/business-profile` - Update business profile
3. **DELETE** `/auth/business-profile` - Delete business profile

## Usage Examples

### Register New User

```dart
final authProvider = context.read<AuthProvider>();
final success = await authProvider.signUpPersonal(
  fullName: 'John Doe',
  email: 'john@example.com',
  phoneNumber: '+1234567890',
  password: 'SecurePassword123!',
);
```

### Login User

```dart
final authProvider = context.read<AuthProvider>();
final success = await authProvider.signIn(
  email: 'john@example.com',
  password: 'SecurePassword123!',
);
```

### Create Business Profile

```dart
final authProvider = context.read<AuthProvider>();
final success = await authProvider.createBusinessProfile(
  businessName: 'John\'s Business LLC',
);
```

## Error Handling

The API integration includes comprehensive error handling:

### Network Errors
- Connection timeouts
- Network connectivity issues
- Server unavailability

### API Errors
- Validation errors (400 Bad Request)
- Authentication errors (401 Unauthorized)
- Authorization errors (403 Forbidden)
- Not found errors (404 Not Found)
- Rate limiting (429 Too Many Requests)
- Server errors (500 Internal Server Error)

### Error Response Format

```json
{
  "success": false,
  "message": "Validation failed",
  "errors": {
    "email": ["Email is already registered"],
    "password": ["Password must be at least 8 characters"]
  }
}
```

## Token Management

### Automatic Token Refresh

The app automatically handles JWT token refresh:

1. **Access Token**: Expires in 1 hour
2. **Refresh Token**: Expires in 30 days
3. **Automatic Refresh**: When access token expires, app automatically uses refresh token to get new access token

### Token Storage

Tokens are securely stored using SharedPreferences:

- `access_token`: Current access token
- `refresh_token`: Current refresh token
- `user_authenticated`: Authentication status flag

## Testing the Integration

### 1. Start Your Laravel API Server

```bash
cd your-laravel-project
php artisan serve
```

The server should be running on `http://localhost:8000`

### 2. Run the Flutter App

```bash
flutter run
```

### 3. Test Authentication Flow

1. **Landing Page**: Tap "Get Started"
2. **Personal Profile**: Fill in the form and submit
3. **Business Profile**: Create or skip business profile
4. **Main App**: Should navigate to main app after successful registration

### 4. Test Login Flow

1. **Landing Page**: Tap "Sign In"
2. **Login Form**: Enter credentials and submit
3. **Main App**: Should navigate to main app after successful login

## Debugging

### Enable API Logging

Add this to your `main.dart` for debugging:

```dart
import 'package:flutter/foundation.dart';

void main() {
  if (kDebugMode) {
    // Enable HTTP logging in debug mode
    debugPrint('API Base URL: ${ApiConfig.baseUrl}');
  }
  runApp(MyApp());
}
```

### Common Issues

1. **Connection Refused**: Make sure Laravel server is running on port 8000
2. **CORS Issues**: Configure CORS in your Laravel API for Flutter app
3. **Token Expired**: App should automatically refresh tokens
4. **Network Timeout**: Check internet connection and server status

## Security Considerations

1. **HTTPS in Production**: Always use HTTPS for production API calls
2. **Token Security**: Tokens are stored securely in SharedPreferences
3. **Certificate Pinning**: Consider implementing certificate pinning for production
4. **Request Validation**: All API requests include proper validation

## Future Enhancements

1. **Offline Support**: Implement offline caching and sync
2. **Push Notifications**: Add push notification support
3. **Biometric Authentication**: Integrate biometric login
4. **Social Login**: Add Google/Apple sign-in support
5. **API Caching**: Implement response caching for better performance

## Support

For API integration issues:

1. Check the Laravel API server logs
2. Verify API endpoints are working with Postman/curl
3. Check Flutter app logs for network errors
4. Ensure proper CORS configuration in Laravel


