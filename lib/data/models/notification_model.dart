import '../../domain/entities/notification.dart';

class NotificationModel extends Notification {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.message,
    required super.type,
    super.isRead,
    required super.scheduledDate,
    super.sentDate,
    super.loanId,
    super.paymentId,
    required super.createdAt,
  });
  
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      isRead: json['is_read'] ?? false,
      scheduledDate: DateTime.parse(json['scheduled_date']),
      sentDate: json['sent_date'] != null ? DateTime.parse(json['sent_date']) : null,
      loanId: json['loan_id'],
      paymentId: json['payment_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'is_read': isRead,
      'scheduled_date': scheduledDate.toIso8601String(),
      'sent_date': sentDate?.toIso8601String(),
      'loan_id': loanId,
      'payment_id': paymentId,
      'created_at': createdAt.toIso8601String(),
    };
  }
  
  factory NotificationModel.fromEntity(Notification notification) {
    return NotificationModel(
      id: notification.id,
      title: notification.title,
      message: notification.message,
      type: notification.type,
      isRead: notification.isRead,
      scheduledDate: notification.scheduledDate,
      sentDate: notification.sentDate,
      loanId: notification.loanId,
      paymentId: notification.paymentId,
      createdAt: notification.createdAt,
    );
  }
}
