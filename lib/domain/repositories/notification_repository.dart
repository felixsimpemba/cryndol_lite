import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<Notification>>> getAllNotifications();
  Future<Either<Failure, List<Notification>>> getUnreadNotifications();
  Future<Either<Failure, Notification>> getNotificationById(String id);
  Future<Either<Failure, Notification>> createNotification(Notification notification);
  Future<Either<Failure, Notification>> updateNotification(Notification notification);
  Future<Either<Failure, bool>> deleteNotification(String id);
  Future<Either<Failure, bool>> markAsRead(String id);
  Future<Either<Failure, bool>> markAllAsRead();
  Future<Either<Failure, List<Notification>>> getScheduledNotifications();
  Future<Either<Failure, bool>> schedulePaymentReminder(
    String loanId,
    DateTime reminderDate,
    String message,
  );
}
