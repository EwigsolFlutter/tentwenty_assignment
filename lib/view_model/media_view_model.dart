import 'package:flutter/cupertino.dart';
import 'package:tentwenty_assignment/model/apis/api_response.dart';
import 'package:tentwenty_assignment/model/media.dart';
import 'package:tentwenty_assignment/model/media_repository.dart';

class MediaViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse _apiResponseVIDEO = ApiResponse.initial('Empty data');
  ApiResponse _apiGenreList = ApiResponse.initial('Empty data');
  ApiResponse _apiResponseSEARCH = ApiResponse.initial('Empty data');

  Media? _media;

  MediaViewModel() {
    fetchMediaData('');
  }

  ApiResponse get response {
    return _apiResponse;
  }

  ApiResponse get responseVIDEO {
    return _apiResponseVIDEO;
  }

  ApiResponse get responseGenre {
    return _apiGenreList;
  }

  ApiResponse get responseSEARCH {
    return _apiResponseSEARCH;
  }

  Media? get media {
    return _media;
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.
  Future<void> fetchMediaData(String value) async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    notifyListeners();
    try {
      List<Media> mediaList = await MediaRepository().fetchMediaList(value);
      _apiResponse = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  Future<void> fetchVideoDataKey(String id) async {
    _apiResponseVIDEO = ApiResponse.loading('Fetching  data');
    notifyListeners();
    try {
      String mediaList = await MediaRepository().fetchVideoID(id);
      _apiResponseVIDEO = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiResponseVIDEO = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  Future<void> fetchGenereList() async {
    _apiGenreList = ApiResponse.loading('Fetching  data');
    notifyListeners();
    try {
      List mediaList = await MediaRepository().getGenreList();
      _apiGenreList = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiGenreList = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  Future<void> fetchSearch(String q) async {
    _apiResponseSEARCH = ApiResponse.loading('Fetching  data');
    notifyListeners();
    try {
      List mediaList = await MediaRepository().getSearchResult(q);
      _apiResponseSEARCH = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiResponseSEARCH = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  void setSelectedMedia(Media? media) {
    _media = media;
    notifyListeners();
  }
}
