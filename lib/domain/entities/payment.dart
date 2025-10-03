import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final String id;
  final String loanId;
  final double amount;
  final DateTime paymentDate;
  final String paymentMethod;
  final String status;
  final String? receiptPath;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const Payment({
    required this.id,
    required this.loanId,
    required this.amount,
    required this.paymentDate,
    required this.paymentMethod,
    required this.status,
    this.receiptPath,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  
  Payment copyWith({
    String? id,
    String? loanId,
    double? amount,
    DateTime? paymentDate,
    String? paymentMethod,
    String? status,
    String? receiptPath,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Payment(
      id: id ?? this.id,
      loanId: loanId ?? this.loanId,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      receiptPath: receiptPath ?? this.receiptPath,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  bool get isCompleted => status == 'completed';
  bool get isPending => status == 'pending';
  bool get isMissed => status == 'missed';
  
  @override
  List<Object?> get props => [
        id,
        loanId,
        amount,
        paymentDate,
        paymentMethod,
        status,
        receiptPath,
        notes,
        createdAt,
        updatedAt,
      ];
}
