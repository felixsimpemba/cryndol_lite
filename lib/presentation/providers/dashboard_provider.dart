import 'package:flutter/material.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/entities/dashboard.dart';

enum DashboardStatus { initial, loading, loaded, error }

class DashboardProvider with ChangeNotifier {
  final DashboardRepositoryImpl _repository;

  DashboardProvider({DashboardRepositoryImpl? repository})
      : _repository = repository ?? DashboardRepositoryImpl();

  DashboardStatus _status = DashboardStatus.initial;
  DashboardSummary? _summary;
  String? _errorMessage;

  DashboardStatus get status => _status;
  DashboardSummary? get summary => _summary;
  String? get errorMessage => _errorMessage;

  Future<void> loadSummary({required String token}) async {
    print('Dashboard Provider: Starting to load summary data');
    _status = DashboardStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _repository.getSummary(token: token);
    result.fold(
      (failure) {
        print('Dashboard Provider: Failed to load summary - ${failure.runtimeType}');
        _status = DashboardStatus.error;
        _errorMessage = 'Failed to load data';
      },
      (data) {
        print('Dashboard Provider: Successfully loaded summary data');
        print('Dashboard Provider: Total borrowers: ${data.totalBorrowers}, Total loans: ${data.totalLoans}');
        _summary = data;
        _status = DashboardStatus.loaded;
      },
    );
    notifyListeners();
  }
}


