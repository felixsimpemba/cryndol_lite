import 'package:equatable/equatable.dart';

class ProfitPoint extends Equatable {
  final DateTime date;
  final double amount;

  const ProfitPoint({required this.date, required this.amount});

  @override
  List<Object?> get props => [date, amount];
}

class DashboardSummary extends Equatable {
  final int totalBorrowers;
  final int totalLoans;
  final double totalOutstandingAmount;
  final double totalPaidAmount;
  final double currentBalance; // How much the business currently has
  final int loansDueInNext7Days;
  final List<ProfitPoint> profitTrend;

  const DashboardSummary({
    required this.totalBorrowers,
    required this.totalLoans,
    required this.totalOutstandingAmount,
    required this.totalPaidAmount,
    required this.currentBalance,
    required this.loansDueInNext7Days,
    this.profitTrend = const [],
  });

  @override
  List<Object?> get props => [
        totalBorrowers,
        totalLoans,
        totalOutstandingAmount,
        totalPaidAmount,
        currentBalance,
        loansDueInNext7Days,
        profitTrend,
      ];
}


