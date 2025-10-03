import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/payment.dart';
import '../../repositories/payment_repository.dart';

class CreatePayment {
  final PaymentRepository repository;
  
  CreatePayment(this.repository);
  
  Future<Either<Failure, Payment>> call(Payment payment) async {
    // Validation logic
    if (payment.amount <= 0) {
      return const Left(ValidationFailure(message: 'Payment amount must be greater than 0'));
    }
    
    if (payment.paymentDate.isAfter(DateTime.now())) {
      return const Left(ValidationFailure(message: 'Payment date cannot be in the future'));
    }
    
    return await repository.createPayment(payment);
  }
}
