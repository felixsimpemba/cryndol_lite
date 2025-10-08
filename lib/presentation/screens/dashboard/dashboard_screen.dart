import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/auth_provider.dart';
import '../../../domain/entities/dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Load data once authenticated token is available
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final auth = context.read<AuthProvider>();
      final token = auth.isAuthenticated ? auth.accessToken : null;
      if (token != null) {
        await context.read<DashboardProvider>().loadSummary(token: token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, _) {
        // Always show the UI, even if loading or error
        final summary = provider.summary ?? _getEmptySummary();
        final isLoading = provider.status == DashboardStatus.loading;
        
        return RefreshIndicator(
          onRefresh: () async {
            final auth = context.read<AuthProvider>();
            final token = auth.isAuthenticated ? auth.accessToken : null;
            if (token != null) {
              await provider.loadSummary(token: token);
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildStatsGrid(context, summary),
                    const SizedBox(height: 16),
                    _buildProfitChartCard(context, summary),
                  ],
                ),
              ),
              if (isLoading)
                const Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 8),
                            Text('Loading...'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (provider.status == DashboardStatus.error)
                Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Card(
                      color: Theme.of(context).colorScheme.errorContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
                              Icons.error_outline,
                              size: 16,
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                            const SizedBox(width: 8),
            Text(
                              'Failed to load data',
              style: TextStyle(
                                color: Theme.of(context).colorScheme.onErrorContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsGrid(BuildContext context, DashboardSummary summary) {
    final cards = <Widget>[
      _StatCard(
        title: 'Borrowers',
        value: summary.totalBorrowers.toString(),
        icon: Icons.groups,
        color: Colors.blue,
      ),
      _StatCard(
        title: 'Total Loans',
        value: summary.totalLoans.toString(),
        icon: Icons.request_page,
        color: Colors.indigo,
      ),
      _StatCard(
        title: 'Outstanding',
        value: _formatCurrency(summary.totalOutstandingAmount),
        icon: Icons.trending_up,
        color: Colors.orange,
      ),
      _StatCard(
        title: 'Paid',
        value: _formatCurrency(summary.totalPaidAmount),
        icon: Icons.payments,
        color: Colors.green,
      ),
      _StatCard(
        title: 'Balance',
        value: _formatCurrency(summary.currentBalance),
        icon: Icons.account_balance_wallet,
        color: Colors.teal,
      ),
      _StatCard(
        title: 'Due in 7 days',
        value: summary.loansDueInNext7Days.toString(),
        icon: Icons.upcoming,
        color: Colors.red,
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: cards,
    );
  }

  Widget _buildProfitChartCard(BuildContext context, DashboardSummary summary) {
    // Convert profit trend to FlSpot list safely
    List<FlSpot> spots = [];
    if (summary.profitTrend.isNotEmpty) {
      try {
        spots = summary.profitTrend
            .map<FlSpot>((p) => FlSpot(
                  p.date.millisecondsSinceEpoch.toDouble(), 
                  p.amount.toDouble()
                ))
            .toList();
      } catch (e) {
        // If conversion fails, use empty list
        spots = [];
      }
    }

    // If no data points, show empty chart with a message
    if (spots.isEmpty) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profit Trend',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              AspectRatio(
                aspectRatio: 1.8,
                child: Center(
                  child: Text(
                    'No profit data available',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profit Trend',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1.8,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(2);
  }

  DashboardSummary _getEmptySummary() {
    return const DashboardSummary(
      totalBorrowers: 0,
      totalLoans: 0,
      totalOutstandingAmount: 0.0,
      totalPaidAmount: 0.0,
      currentBalance: 0.0,
      loansDueInNext7Days: 0,
      profitTrend: [],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
