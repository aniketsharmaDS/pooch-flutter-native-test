import 'package:poochcare/features/videos/data/api/video_api_service.dart';
import 'package:poochcare/features/videos/data/mappers/video_mapper.dart';
import 'package:poochcare/features/videos/domain/models/video_item.dart';

class VideosRepository {
  const VideosRepository(this._api);

  final VideoApiService _api;

  Future<List<VideoItem>> fetchVideos({required int page}) async {
    final responses = await _api.getVideos(page: page);
    return VideoMapper.listToDomain(responses);
  }
}
