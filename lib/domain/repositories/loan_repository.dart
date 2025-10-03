import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/loan.dart';

abstract class LoanRepository {
  Future<Either<Failure, List<Loan>>> getAllLoans();
  Future<Either<Failure, List<Loan>>> getActiveLoans();
  Future<Either<Failure, List<Loan>>> getLoansByType(String loanType);
  Future<Either<Failure, Loan>> getLoanById(String id);
  Future<Either<Failure, Loan>> createLoan(Loan loan);
  Future<Either<Failure, Loan>> updateLoan(Loan loan);
  Future<Either<Failure, bool>> deleteLoan(String id);
  Future<Either<Failure, List<Loan>>> searchLoans(String query);
  Future<Either<Failure, double>> getTotalDebt();
  Future<Either<Failure, double>> getTotalPaid();
  Future<Either<Failure, Map<String, double>>> getLoanStatistics();
}
