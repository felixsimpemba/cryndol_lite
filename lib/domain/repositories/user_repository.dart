import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, User>> updateUser(User user);
  Future<Either<Failure, bool>> setUserPin(String pin);
  Future<Either<Failure, bool>> verifyUserPin(String pin);
  Future<Either<Failure, bool>> enableBiometric(bool enabled);
  Future<Either<Failure, bool>> isBiometricEnabled();
  Future<Either<Failure, bool>> deleteUser();
}
