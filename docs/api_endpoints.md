# API Endpoints Specification

## Base URL
```
https://api.cryndol.com/v1
```

## Authentication
All endpoints (except registration and login) require authentication using Bearer token in the Authorization header:
```
Authorization: Bearer <jwt_token>
```

---

## 1. User Authentication Endpoints

### 1.1 Register Personal Profile
**POST** `/auth/register/personal`

Creates a new user account with personal information.

#### Request Body
```json
{
  "fullName": "John Doe",
  "email": "john.doe@example.com",
  "phoneNumber": "+1234567890",
  "password": "SecurePassword123!",
  "acceptTerms": true
}
```

#### Response
**Success (201 Created)**
```json
{
  "success": true,
  "message": "Personal profile created successfully",
  "data": {
    "user": {
      "id": "user_123456",
      "fullName": "John Doe",
      "email": "john.doe@example.com",
      "phoneNumber": "+1234567890",
      "createdAt": "2024-01-15T10:30:00Z",
      "updatedAt": "2024-01-15T10:30:00Z"
    },
    "tokens": {
      "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "expiresIn": 3600
    }
  }
}
```

**Error (400 Bad Request)**
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

---

### 1.2 Create Business Profile
**POST** `/auth/business-profile`

Creates or updates business profile for authenticated user.

#### Request Body
```json
{
  "businessName": "John's Consulting LLC"
}
```

#### Response
**Success (201 Created)**
```json
{
  "success": true,
  "message": "Business profile created successfully",
  "data": {
    "businessProfile": {
      "id": "business_789012",
      "businessName": "John's Consulting LLC",
      "createdAt": "2024-01-15T10:35:00Z",
      "updatedAt": "2024-01-15T10:35:00Z"
    }
  }
}
```

**Error (400 Bad Request)**
```json
{
  "success": false,
  "message": "Validation failed",
  "errors": {
    "businessName": ["Business name is required"]
  }
}
```

---

### 1.3 Login
**POST** `/auth/login`

Authenticates user and returns access tokens.

#### Request Body
```json
{
  "email": "john.doe@example.com",
  "password": "SecurePassword123!"
}
```

#### Response
**Success (200 OK)**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": "user_123456",
      "fullName": "John Doe",
      "email": "john.doe@example.com",
      "phoneNumber": "+1234567890",
      "hasBusinessProfile": true,
      "createdAt": "2024-01-15T10:30:00Z",
      "updatedAt": "2024-01-15T10:30:00Z"
    },
    "tokens": {
      "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "expiresIn": 3600
    }
  }
}
```

**Error (401 Unauthorized)**
```json
{
  "success": false,
  "message": "Invalid credentials"
}
```

---

### 1.4 Refresh Token
**POST** `/auth/refresh`

Refreshes access token using refresh token.

#### Request Body
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### Response
**Success (200 OK)**
```json
{
  "success": true,
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expiresIn": 3600
  }
}
```

---

### 1.5 Logout
**POST** `/auth/logout`

Invalidates user tokens and logs out user.

#### Request Headers
```
Authorization: Bearer <access_token>
```

#### Response
**Success (200 OK)**
```json
{
  "success": true,
  "message": "Logout successful"
}
```

---

### 1.6 Get User Profile
**GET** `/auth/profile`

Retrieves current user profile information.

#### Request Headers
```
Authorization: Bearer <access_token>
```

#### Response
**Success (200 OK)**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "user_123456",
      "fullName": "John Doe",
      "email": "john.doe@example.com",
      "phoneNumber": "+1234567890",
      "hasBusinessProfile": true,
      "createdAt": "2024-01-15T10:30:00Z",
      "updatedAt": "2024-01-15T10:30:00Z"
    },
    "businessProfile": {
      "id": "business_789012",
      "businessName": "John's Consulting LLC",
      "createdAt": "2024-01-15T10:35:00Z",
      "updatedAt": "2024-01-15T10:35:00Z"
    }
  }
}
```

---

## 2. Error Responses

### Common Error Formats

**400 Bad Request**
```json
{
  "success": false,
  "message": "Validation failed",
  "errors": {
    "fieldName": ["Error message 1", "Error message 2"]
  }
}
```

**401 Unauthorized**
```json
{
  "success": false,
  "message": "Authentication required"
}
```

**403 Forbidden**
```json
{
  "success": false,
  "message": "Access denied"
}
```

**404 Not Found**
```json
{
  "success": false,
  "message": "Resource not found"
}
```

**429 Too Many Requests**
```json
{
  "success": false,
  "message": "Rate limit exceeded",
  "retryAfter": 60
}
```

**500 Internal Server Error**
```json
{
  "success": false,
  "message": "Internal server error"
}
```

---

## 3. Data Models

### User Model
```typescript
interface User {
  id: string;
  fullName: string;
  email: string;
  phoneNumber: string;
  hasBusinessProfile: boolean;
  createdAt: string; // ISO 8601 datetime
  updatedAt: string; // ISO 8601 datetime
}
```

### BusinessProfile Model
```typescript
interface BusinessProfile {
  id: string;
  businessName: string;
  createdAt: string; // ISO 8601 datetime
  updatedAt: string; // ISO 8601 datetime
}
```

### Token Model
```typescript
interface TokenPair {
  accessToken: string;
  refreshToken: string;
  expiresIn: number; // seconds
}
```

---

## 4. Security Considerations

### Password Requirements
- Minimum 8 characters
- At least one uppercase letter
- At least one lowercase letter
- At least one number
- At least one special character

### Rate Limiting
- Registration: 5 attempts per hour per IP
- Login: 10 attempts per hour per IP
- General API: 1000 requests per hour per user

### Token Security
- Access tokens expire in 1 hour
- Refresh tokens expire in 30 days
- Tokens are stored securely and cannot be reused after logout

---

## 5. Implementation Notes

### Phase 1 (Current)
- Basic authentication flow
- Personal and business profile creation
- Local data storage with mock API responses

### Phase 2 (Future)
- Real API integration
- Email verification
- Password reset functionality
- Two-factor authentication
- Business profile verification

### Phase 3 (Future)
- Social login (Google, Apple)
- Biometric authentication
- Advanced security features
- Admin panel for user management
