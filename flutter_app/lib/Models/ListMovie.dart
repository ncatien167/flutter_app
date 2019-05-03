
class Response {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<ListMoive> results;

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

class ListMoive {
  final String title;
  final String posterPath;
  final String overview;

  ListMoive.fromJSON(Map<String, dynamic> jsonMap) :
        title = jsonMap['title'],
        posterPath = jsonMap['poster_path'],
        overview = jsonMap['overview'];

  Map<String, dynamic> toJson() => {
    'title' : title,
    'poster_path' : posterPath,
    'overview' : overview,
  };
}