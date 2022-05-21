import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:tentwenty_assignment/model/apis/app_exception.dart';
import 'package:tentwenty_assignment/model/services/base_service.dart';

class MediaService extends BaseService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(BaseService.mediaBaseUrl));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getGenreResponse() async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(BaseService.genresURL));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getVideoResponse(String id) async {
    dynamic responseJson;
    try {
      print(id);
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$id/videos?api_key=1bbaf6df4cf1d3eab11311c65576e59d&append_to_response=videos'));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getSearchResult(String query) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(BaseService.searchNEWURL + query));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    print(response.body);
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('Error occured while communication with server'
            ' with status code : ${response.statusCode}');
    }
  }
}
