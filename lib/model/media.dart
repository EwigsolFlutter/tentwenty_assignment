class Media {
  final String? artistName;
  final String? overview;
  final String? trackName;
  final String? artworkUrl;
  final String? previewUrl;
  final List<dynamic> genres;
  final String release_date;

  Media({
    this.artistName,
    this.overview,
    this.trackName,
    this.artworkUrl,
    this.previewUrl,
    this.genres = const [],
    this.release_date = '',
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      artistName: json['id'].toString(),
      overview: json['overview'] as String?,
      trackName: json['title'] as String?,
      artworkUrl: json['artworkUrl100'] as String?,
      previewUrl: json['poster_path'] as String?,
      genres: json['genre_ids'] as List,
      release_date: json['release_date'],
    );
  }
}
