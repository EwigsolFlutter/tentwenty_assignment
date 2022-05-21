abstract class BaseService {
  static const imagesURL = 'https://image.tmdb.org/t/p/original/';
  static const searchNEWURL =
      'https://api.themoviedb.org/3/search/company?api_key=1bbaf6df4cf1d3eab11311c65576e59d&query=';
  static const String mediaBaseUrl =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=1bbaf6df4cf1d3eab11311c65576e59d";
  static const String searchBaseUrl =
      'https://api.themoviedb.org/3/search/tv?api_key=1bbaf6df4cf1d3eab11311c65576e59d&page=1&include_adult=false';
  static const genresURL =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=1bbaf6df4cf1d3eab11311c65576e59d';
  Future<dynamic> getResponse(String url);
  Future<dynamic> getSearchResult(String query);
  Future<dynamic> getVideoResponse(String id);
  Future<dynamic> getGenreResponse();
}
