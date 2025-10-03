import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/payment.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<Payment>>> getPaymentsByLoanId(String loanId);
  Future<Either<Failure, List<Payment>>> getAllPayments();
  Future<Either<Failure, Payment>> getPaymentById(String id);
  Future<Either<Failure, Payment>> createPayment(Payment payment);
  Future<Either<Failure, Payment>> updatePayment(Payment payment);
  Future<Either<Failure, bool>> deletePayment(String id);
  Future<Either<Failure, List<Payment>>> getUpcomingPayments();
  Future<Either<Failure, List<Payment>>> getOverduePayments();
  Future<Either<Failure, double>> getTotalPaidForLoan(String loanId);
  Future<Either<Failure, Map<String, double>>> getPaymentStatistics();
  Future<Either<Failure, List<Payment>>> getPaymentsByDateRange(
    DateTime startDate,
    DateTime endDate,
  );
}
