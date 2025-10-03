import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/loan.dart';
import '../../repositories/loan_repository.dart';

class GetAllLoans {
  final LoanRepository repository;
  
  GetAllLoans(this.repository);
  
  Future<Either<Failure, List<Loan>>> call() async {
    return await repository.getAllLoans();
  }
}
