
class Response {
  final int page;
  final int totalResults;
  final int totalPages;
  final List results;

  Response.fromJSON(Map<String, dynamic> jsonMap) :
    page = jsonMap['page'],
    totalResults = jsonMap['total_results'],
    totalPages = jsonMap['total_pages'],
    results = jsonMap['results'];

  Map<String, dynamic> toJson() => {
    'page' : page,
    'total_results' : totalResults,
    'total_pages' : totalPages,
    'results' : results,
  };
}

class Movie {
  final String title;
  final String posterPath;
  final String overview;
  final String backdropPath;
  final List genreIds;

  Movie.fromJSON(Map<String, dynamic> jsonMap) :
        title = jsonMap['title'],
        posterPath = jsonMap['poster_path'],
        overview = jsonMap['overview'],
        genreIds = jsonMap['genre_ids'],
        backdropPath = jsonMap['backdrop_path'];

  Map<String, dynamic> toJson() => {
    'title' : title,
    'poster_path' : posterPath,
    'overview' : overview,
    'genre_ids': genreIds, 
    'backdrop_path': backdropPath,
  };
}