class Movie {
  const Movie(
    this.id,
    this.title,
    this.genre,
    this.year,
    this.score,
    this.overview,
    this.posterPath,
  );

  final int id;
  final String title;
  final String genre;
  final int year;
  final double score;
  final String overview;
  final String posterPath;

  String get posterUrl => 'https://image.tmdb.org/t/p/w500/$posterPath';
  String get scoreText => score.toStringAsFixed(1);
}

class SavedMovie {
  SavedMovie(this.movie);

  final Movie movie;
  bool watched = false;
  int? rating;
}

class MovieFilters {
  const MovieFilters({this.genre = 'All genres', this.year, this.score = 0});

  final String genre;
  final int? year;
  final double score;

  bool matches(Movie movie) =>
      (genre == 'All genres' || movie.genre == genre) &&
      (year == null || movie.year >= year!) &&
      movie.score >= score;

  String get summary {
    final yearLabel = year == null ? 'Any year' : '$year+';
    final scoreLabel = score == 0
        ? 'Any score'
        : '${score.toStringAsFixed(1)}+ TMDB';
    return '$genre  ·  $yearLabel  ·  $scoreLabel';
  }
}

// Scores and descriptions are illustrative fixtures for the Step 2.2 UI.
const sampleMovies = [
  Movie(
    1,
    'Interstellar',
    'Sci-Fi',
    2014,
    8.0,
    'A team travels beyond Earth to find a new home for humanity.',
    'gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
  ),
  Movie(
    2,
    'Arrival',
    'Sci-Fi',
    2016,
    7.6,
    'A linguist tries to make contact with visitors whose spacecraft have landed across the planet.',
    'x2FJsf1ElAgr63Y3PNPtJrcmpoe.jpg',
  ),
  Movie(
    3,
    'The Grand Budapest Hotel',
    'Comedy',
    2014,
    8.0,
    'A hotel concierge and a lobby boy become unlikely partners in a missing painting mystery.',
    'eWdyYQreja6JGCzqHWXpWHDrrPo.jpg',
  ),
  Movie(
    4,
    'Parasite',
    'Thriller',
    2019,
    8.5,
    'A family’s new jobs in a wealthy household pull them into a risky deception.',
    '7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
  ),
  Movie(
    5,
    'The Truman Show',
    'Drama',
    1998,
    8.1,
    'An insurance salesman begins to suspect there is something unusual about his seemingly ordinary life.',
    'vuza0WqY239yBXOadKlGwJsZJFE.jpg',
  ),
  Movie(
    6,
    'Spirited Away',
    'Animation',
    2001,
    8.5,
    'A girl must find her way home after wandering into a strange world of spirits.',
    '39wmItIWsg5sZMyRUHLkWBcuVCM.jpg',
  ),
];
