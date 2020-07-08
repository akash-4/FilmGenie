class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<dynamic> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;
  String docID;
  int rate;
  int peopleRated;
  Map<String, dynamic> rates;
  Movie(
      {this.popularity,
      this.voteCount,
      this.video,
      this.posterPath,
      this.rates,
      this.id,
      this.rate,
      this.peopleRated,
      this.docID,
      this.adult,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.title,
      this.voteAverage,
      this.overview,
      this.releaseDate});
}
