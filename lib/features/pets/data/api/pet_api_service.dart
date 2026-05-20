import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/pets/data/models/pet_response.dart';

class PetApiService {
  const PetApiService(this._dio);

  final Dio _dio;

  Future<List<PetResponse>> getPets() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    _dio.options.baseUrl;
    final Map<String, dynamic> raw = <String, dynamic>{
      'success': true,
      'message': 'Pets retrieved successfully',
      'status': 200,
      'data': <Map<String, dynamic>>[
        <String, dynamic>{
          'id': 'pet_1',
          'name': 'Bruno',
          'breed': 'Golden Retriever',
        },
        <String, dynamic>{'id': 'pet_2', 'name': 'Luna', 'breed': 'Beagle'},
      ],
    };
    final ApiResponse envelope = ApiResponseMapper.fromMap(raw);
    final dynamic payload = envelope.data;
    if (payload is! List) {
      return const <PetResponse>[];
    }
    return payload
        .whereType<Map<String, dynamic>>()
        .map(PetResponseMapper.fromMap)
        .toList();
  }

  Future<PetResponse> addPet({
    required String name,
    required String breed,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final Map<String, dynamic> raw = <String, dynamic>{
      'success': true,
      'message': 'Pet added successfully',
      'status': 201,
      'data': <String, dynamic>{
        'id': 'pet_${DateTime.now().millisecondsSinceEpoch}',
        'name': name,
        'breed': breed,
      },
    };
    final ApiResponse envelope = ApiResponseMapper.fromMap(raw);
    if (envelope.data is! Map<String, dynamic>) {
      return const PetResponse();
    }
    return PetResponseMapper.fromMap(envelope.data as Map<String, dynamic>);
  }

  Future<PetResponse> updatePet({
    required String id,
    required String name,
    required String breed,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final Map<String, dynamic> raw = <String, dynamic>{
      'success': true,
      'message': 'Pet updated successfully',
      'status': 200,
      'data': <String, dynamic>{'id': id, 'name': name, 'breed': breed},
    };
    final ApiResponse envelope = ApiResponseMapper.fromMap(raw);
    if (envelope.data is! Map<String, dynamic>) {
      return const PetResponse();
    }
    return PetResponseMapper.fromMap(envelope.data as Map<String, dynamic>);
  }

  Future<void> deletePet(String petId) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }
}
