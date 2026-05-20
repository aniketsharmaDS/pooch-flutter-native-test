import 'package:dio/dio.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/videos/data/models/video_response.dart';

class VideoApiService {
  const VideoApiService(this._dio);

  final Dio _dio;

  Future<List<VideoResponse>> getVideos({required int page}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _dio.options.baseUrl;
    final Map<String, dynamic> raw = <String, dynamic>{
      'success': true,
      'message': 'Videos retrieved successfully',
      'status': 200,
      'data': <Map<String, dynamic>>[
        <String, dynamic>{
          'id': 'vid_1',
          'title': 'How to bathe your puppy',
          'durationLabel': '04:32',
          'thumbnailUrl': 'https://dev-api.pooch.app/static/video-1.jpg',
        },
      ],
    };
    final ApiResponse envelope = ApiResponseMapper.fromMap(raw);
    final dynamic payload = envelope.data;
    if (payload is! List) {
      return const <VideoResponse>[];
    }
    return payload
        .whereType<Map<String, dynamic>>()
        .map(VideoResponseMapper.fromMap)
        .toList();
  }
}
