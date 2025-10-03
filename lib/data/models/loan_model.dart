import '../../domain/entities/loan.dart';

class LoanModel extends Loan {
  const LoanModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.description,
    required super.principalAmount,
    required super.interestRate,
    required super.loanType,
    required super.paymentFrequency,
    required super.startDate,
    required super.endDate,
    required super.lenderName,
    super.lenderContact,
    required super.status,
    required super.currency,
    super.notes,
    super.documentPaths,
    required super.createdAt,
    required super.updatedAt,
  });
  
  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      principalAmount: (json['principal_amount'] as num).toDouble(),
      interestRate: (json['interest_rate'] as num).toDouble(),
      loanType: json['loan_type'],
      paymentFrequency: json['payment_frequency'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      lenderName: json['lender_name'],
      lenderContact: json['lender_contact'],
      status: json['status'],
      currency: json['currency'],
      notes: json['notes'],
      documentPaths: List<String>.from(json['document_paths'] ?? []),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'principal_amount': principalAmount,
      'interest_rate': interestRate,
      'loan_type': loanType,
      'payment_frequency': paymentFrequency,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'lender_name': lenderName,
      'lender_contact': lenderContact,
      'status': status,
      'currency': currency,
      'notes': notes,
      'document_paths': documentPaths,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  factory LoanModel.fromEntity(Loan loan) {
    return LoanModel(
      id: loan.id,
      userId: loan.userId,
      title: loan.title,
      description: loan.description,
      principalAmount: loan.principalAmount,
      interestRate: loan.interestRate,
      loanType: loan.loanType,
      paymentFrequency: loan.paymentFrequency,
      startDate: loan.startDate,
      endDate: loan.endDate,
      lenderName: loan.lenderName,
      lenderContact: loan.lenderContact,
      status: loan.status,
      currency: loan.currency,
      notes: loan.notes,
      documentPaths: loan.documentPaths,
      createdAt: loan.createdAt,
      updatedAt: loan.updatedAt,
    );
  }
}
