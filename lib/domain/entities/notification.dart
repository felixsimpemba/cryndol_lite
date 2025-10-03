import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final String id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final DateTime scheduledDate;
  final DateTime? sentDate;
  final String? loanId;
  final String? paymentId;
  final DateTime createdAt;
  
  const Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.isRead = false,
    required this.scheduledDate,
    this.sentDate,
    this.loanId,
    this.paymentId,
    required this.createdAt,
  });
  
  Notification copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    bool? isRead,
    DateTime? scheduledDate,
    DateTime? sentDate,
    String? loanId,
    String? paymentId,
    DateTime? createdAt,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      sentDate: sentDate ?? this.sentDate,
      loanId: loanId ?? this.loanId,
      paymentId: paymentId ?? this.paymentId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  
  bool get isScheduled => scheduledDate.isAfter(DateTime.now());
  bool get isOverdue => sentDate != null && sentDate!.isBefore(DateTime.now());
  
  @override
  List<Object?> get props => [
        id,
        title,
        message,
        type,
        isRead,
        scheduledDate,
        sentDate,
        loanId,
        paymentId,
        createdAt,
      ];
}
