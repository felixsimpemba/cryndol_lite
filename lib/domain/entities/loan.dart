import 'package:equatable/equatable.dart';

class Loan extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String description;
  final double principalAmount;
  final double interestRate;
  final String loanType;
  final String paymentFrequency;
  final DateTime startDate;
  final DateTime endDate;
  final String lenderName;
  final String? lenderContact;
  final String status;
  final String currency;
  final String? notes;
  final List<String> documentPaths;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const Loan({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.principalAmount,
    required this.interestRate,
    required this.loanType,
    required this.paymentFrequency,
    required this.startDate,
    required this.endDate,
    required this.lenderName,
    this.lenderContact,
    required this.status,
    required this.currency,
    this.notes,
    this.documentPaths = const [],
    required this.createdAt,
    required this.updatedAt,
  });
  
  Loan copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    double? principalAmount,
    double? interestRate,
    String? loanType,
    String? paymentFrequency,
    DateTime? startDate,
    DateTime? endDate,
    String? lenderName,
    String? lenderContact,
    String? status,
    String? currency,
    String? notes,
    List<String>? documentPaths,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Loan(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      principalAmount: principalAmount ?? this.principalAmount,
      interestRate: interestRate ?? this.interestRate,
      loanType: loanType ?? this.loanType,
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      lenderName: lenderName ?? this.lenderName,
      lenderContact: lenderContact ?? this.lenderContact,
      status: status ?? this.status,
      currency: currency ?? this.currency,
      notes: notes ?? this.notes,
      documentPaths: documentPaths ?? this.documentPaths,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  // Calculated properties
  int get totalPayments {
    final duration = endDate.difference(startDate);
    switch (paymentFrequency.toLowerCase()) {
      case 'weekly':
        return (duration.inDays / 7).ceil();
      case 'bi-weekly':
        return (duration.inDays / 14).ceil();
      case 'monthly':
        return ((duration.inDays / 30.44)).ceil();
      case 'quarterly':
        return (duration.inDays / 91.25).ceil();
      case 'yearly':
        return (duration.inDays / 365.25).ceil();
      default:
        return (duration.inDays / 30.44).ceil();
    }
  }
  
  double get monthlyPayment {
    // EMI calculation: P * [r(1+r)^n] / [(1+r)^n - 1]
    final monthlyRate = interestRate / 100 / 12;
    final numPayments = totalPayments;
    
    if (monthlyRate == 0) {
      return principalAmount / numPayments;
    }
    
    final numerator = principalAmount * monthlyRate * 
        (1 + monthlyRate).pow(numPayments);
    final denominator = (1 + monthlyRate).pow(numPayments) - 1;
    
    return numerator / denominator;
  }
  
  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        principalAmount,
        interestRate,
        loanType,
        paymentFrequency,
        startDate,
        endDate,
        lenderName,
        lenderContact,
        status,
        currency,
        notes,
        documentPaths,
        createdAt,
        updatedAt,
      ];
}

extension on double {
  double pow(int exponent) {
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= this;
    }
    return result;
  }
}
