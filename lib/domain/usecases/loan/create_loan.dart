import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/loan.dart';
import '../../repositories/loan_repository.dart';

class CreateLoan {
  final LoanRepository repository;
  
  CreateLoan(this.repository);
  
  Future<Either<Failure, Loan>> call(Loan loan) async {
    // Validation logic can be added here
    if (loan.principalAmount <= 0) {
      return const Left(ValidationFailure(message: 'Principal amount must be greater than 0'));
    }
    
    if (loan.interestRate < 0) {
      return const Left(ValidationFailure(message: 'Interest rate cannot be negative'));
    }
    
    if (loan.endDate.isBefore(loan.startDate)) {
      return const Left(ValidationFailure(message: 'End date must be after start date'));
    }
    
    return await repository.createLoan(loan);
  }
}
