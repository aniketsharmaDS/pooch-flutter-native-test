import 'package:poochcare/features/home/data/api/home_api_service.dart';
import 'package:poochcare/features/home/data/mappers/dashboard_mapper.dart';

class HomeRepository {
  const HomeRepository(this._api);

  final HomeApiService _api;

  Future<DashboardDomainData> fetchDashboardData() async {
    final response = await _api.getDashboard();
    return DashboardMapper.toDomain(response);
  }
}
