import '../../domain/entities/payment.dart';

class PaymentModel extends Payment {
  const PaymentModel({
    required super.id,
    required super.loanId,
    required super.amount,
    required super.paymentDate,
    required super.paymentMethod,
    required super.status,
    super.receiptPath,
    super.notes,
    required super.createdAt,
    required super.updatedAt,
  });
  
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      loanId: json['loan_id'],
      amount: (json['amount'] as num).toDouble(),
      paymentDate: DateTime.parse(json['payment_date']),
      paymentMethod: json['payment_method'],
      status: json['status'],
      receiptPath: json['receipt_path'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'loan_id': loanId,
      'amount': amount,
      'payment_date': paymentDate.toIso8601String(),
      'payment_method': paymentMethod,
      'status': status,
      'receipt_path': receiptPath,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  factory PaymentModel.fromEntity(Payment payment) {
    return PaymentModel(
      id: payment.id,
      loanId: payment.loanId,
      amount: payment.amount,
      paymentDate: payment.paymentDate,
      paymentMethod: payment.paymentMethod,
      status: payment.status,
      receiptPath: payment.receiptPath,
      notes: payment.notes,
      createdAt: payment.createdAt,
      updatedAt: payment.updatedAt,
    );
  }
}
