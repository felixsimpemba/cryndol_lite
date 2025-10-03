class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final Map<String, List<String>>? errors;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null && fromJsonT != null 
          ? fromJsonT(json['data']) 
          : json['data'],
      errors: json['errors'] != null 
          ? Map<String, List<String>>.from(
              json['errors'].map(
                (key, value) => MapEntry(
                  key,
                  List<String>.from(value),
                ),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'errors': errors,
    };
  }
}
