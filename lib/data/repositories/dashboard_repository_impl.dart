import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../data/models/dashboard_model.dart';
import '../../domain/entities/dashboard.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../data_sources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remote;

  DashboardRepositoryImpl({DashboardRemoteDataSource? remote})
      : _remote = remote ?? DashboardRemoteDataSource();

  @override
  Future<Either<Failure, DashboardSummary>> getSummary({required String token}) async {
    try {
      final response = await _remote.getSummary(token: token);
      if (response.success && response.data != null) {
        return Right(response.data as DashboardSummaryModel);
      }
      return Left(ServerFailure(message: response.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


