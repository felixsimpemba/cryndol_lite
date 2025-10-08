import '../../core/network/api_client.dart';
import '../../data/models/api_response.dart';
import '../models/dashboard_model.dart';

class DashboardRemoteDataSource {
  final ApiClient _apiClient;

  DashboardRemoteDataSource({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  Future<ApiResponse<DashboardSummaryModel>> getSummary({required String token}) async {
    print('Dashboard API: Fetching dashboard summary');
    print('Dashboard API: Using token: ${token.substring(0, 20)}...');
    
    final response = await _apiClient.get<DashboardSummaryModel>(
      '/dashboard/summary',
      token: token,
      fromJson: (data) {
        try {
          print('Dashboard API: Parsing JSON data...');
          print('Dashboard API: Data type: ${data.runtimeType}');
          print('Dashboard API: Data content: $data');
          
          final result = DashboardSummaryModel.fromJson(data as Map<String, dynamic>);
          print('Dashboard API: Successfully parsed dashboard summary');
          return result;
        } catch (e, stackTrace) {
          print('Dashboard API: JSON parsing error: $e');
          print('Dashboard API: Stack trace: $stackTrace');
          rethrow;
        }
      },
    );
    
    print('Dashboard API: Summary fetch ${response.success ? "successful" : "failed"}');
    if (!response.success) {
      print('Dashboard API: Error message: ${response.message}');
    }
    
    return response;
  }
}


