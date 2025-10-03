class BusinessProfileModel {
  final String id;
  final String businessName;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BusinessProfileModel({
    required this.id,
    required this.businessName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BusinessProfileModel.fromJson(Map<String, dynamic> json) {
    return BusinessProfileModel(
      id: json['id'] ?? '',
      businessName: json['businessName'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'businessName': businessName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
