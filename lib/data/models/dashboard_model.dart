import '../../domain/entities/dashboard.dart';

class ProfitPointModel extends ProfitPoint {
  const ProfitPointModel({required super.date, required super.amount});

  factory ProfitPointModel.fromJson(Map<String, dynamic> json) {
    return ProfitPointModel(
      date: DateTime.parse(json['date']),
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'amount': amount,
      };
}

class DashboardSummaryModel extends DashboardSummary {
  const DashboardSummaryModel({
    required super.totalBorrowers,
    required super.totalLoans,
    required super.totalOutstandingAmount,
    required super.totalPaidAmount,
    required super.currentBalance,
    required super.loansDueInNext7Days,
    super.profitTrend = const [],
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryModel(
      totalBorrowers: json['totalBorrowers'] as int,
      totalLoans: json['totalLoans'] as int,
      totalOutstandingAmount: (json['totalOutstandingAmount'] as num).toDouble(),
      totalPaidAmount: (json['totalPaidAmount'] as num).toDouble(),
      currentBalance: (json['currentBalance'] as num).toDouble(),
      loansDueInNext7Days: json['loansDueInNext7Days'] as int,
      profitTrend: (json['profitTrend'] as List<dynamic>? ?? [])
          .map((e) => ProfitPointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'totalBorrowers': totalBorrowers,
        'totalLoans': totalLoans,
        'totalOutstandingAmount': totalOutstandingAmount,
        'totalPaidAmount': totalPaidAmount,
        'currentBalance': currentBalance,
        'loansDueInNext7Days': loansDueInNext7Days,
        'profitTrend': profitTrend
            .map((p) => ProfitPointModel(date: p.date, amount: p.amount).toJson())
            .toList(),
      };
}


