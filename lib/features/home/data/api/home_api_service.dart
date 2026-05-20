import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/home/data/models/dashboard_response.dart';

class HomeApiService {
  const HomeApiService(this._dio);

  final Dio _dio;

  Future<DashboardResponse> getDashboard() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    _dio.options.baseUrl;
    final Map<String, dynamic> raw = <String, dynamic>{
      'success': true,
      'message': 'Dashboard loaded successfully',
      'status': 200,
      'data': <String, dynamic>{
        'user': <String, dynamic>{
          'id': 'u_1',
          'name': 'Pooch User',
          'email': 'user@pooch.app',
        },
        'cart': <String, dynamic>{'itemsCount': 2, 'totalAmount': 59.99},
        'pets': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 'pet_1',
            'name': 'Bruno',
            'breed': 'Golden Retriever',
          },
          <String, dynamic>{'id': 'pet_2', 'name': 'Luna', 'breed': 'Beagle'},
        ],
        'appointments': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 'appointment_1',
            'petId': 'pet_1',
            'service': 'Grooming',
            'dateLabel': '20 Mar, 10:30 AM',
          },
        ],
      },
    };
    final ApiResponse envelope = ApiResponseMapper.fromMap(raw);
    if (envelope.data is! Map<String, dynamic>) {
      return const DashboardResponse();
    }
    return DashboardResponseMapper.fromMap(
      envelope.data as Map<String, dynamic>,
    );
  }
}
