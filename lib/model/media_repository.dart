import 'package:tentwenty_assignment/model/media.dart';
import 'package:tentwenty_assignment/model/services/base_service.dart';
import 'package:tentwenty_assignment/model/services/media_service.dart';

class MediaRepository {
  final BaseService _mediaService = MediaService();

  Future<List<Media>> fetchMediaList(String value) async {
    dynamic response = await _mediaService.getResponse(value);
    final jsonData = response['results'] as List;
    List<Media> mediaList =
        jsonData.map((tagJson) => Media.fromJson(tagJson)).toList();
    return mediaList;
  }

  Future<String> fetchVideoID(String value) async {
    dynamic response = await _mediaService.getVideoResponse(value);
    print(response);
    final jsonData = response['results'];

    return jsonData[0]['key'];
  }

  Future<List> getGenreList() async {
    dynamic response = await _mediaService.getGenreResponse();
    print(response);
    final jsonData = response['genres'] as List;
    return jsonData;
  }

  Future<List> getSearchResult(String q) async {
    dynamic response = await _mediaService.getSearchResult(q);
    print(response);
    final jsonData = response['results'] as List;
    return jsonData;
  }
}
