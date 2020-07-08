import 'package:filmgenie/Animations/FadeAnimation.dart';
import 'package:filmgenie/constants/color.dart';
import 'package:filmgenie/models/movieModel.dart';
import 'package:filmgenie/pages/specificMovieType.dart';
import 'package:filmgenie/widgets/movieTile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyMovieApp extends StatefulWidget {
  @override
  _MyMovieAppState createState() => _MyMovieAppState();
}

class _MyMovieAppState extends State<MyMovieApp> {
  var baseImageUrl = "https://image.tmdb.org/t/p/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black1,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          FadeAnimation(
              0.6,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyMovie(
                                mType: "topRatedMovies",
                                type: "Top Rated Movies",
                              ),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Top Rated ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontFamily: "Proxima Nova")),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 100,
                            height: 20,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: RotatedBox(
                                  quarterTurns: 2,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.red,
                                    size: 15,
                                  )),
                            ),
                          ),
                        ],
                      )),
                  con('topRatedMovies'),
                ],
              )),
          FadeAnimation(
              1.2,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyMovie(
                              mType: "popularMovies",
                              type: "Popular Movies",
                            ),
                          ));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Popular Movies",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontFamily: "Proxima Nova")),
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              width: 100,
                              height: 20,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: RotatedBox(
                                    quarterTurns: 2,
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.red,
                                      size: 15,
                                    )),
                              )),
                        ]),
                  ),
                  con('popularMovies'),
                ],
              )),
          FadeAnimation(
              1.8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyMovie(
                                mType: "upcomingMovies",
                                type: "Upcoming Movies",
                              ),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Upcoming Movies",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontFamily: "Proxima Nova")),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 100,
                            height: 20,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: RotatedBox(
                                  quarterTurns: 2,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.red,
                                    size: 15,
                                  )),
                            ),
                          ),
                        ],
                      )),
                  con('upcomingMovies'),
                ],
              )),
          FadeAnimation(
              2.4,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyMovie(
                                mType: "allMovies",
                                type: "All Movies",
                              ),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("All Movies",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontFamily: "Proxima Nova")),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 100,
                            height: 20,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: RotatedBox(
                                  quarterTurns: 2,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.red,
                                    size: 15,
                                  )),
                            ),
                          ),
                        ],
                      )),
                  con('allMovies'),
                ],
              )),
        ],
      ),
    );
  }

  Widget con(String str) {
    return Container(
      height: 250,
      child: StreamBuilder(
        stream: Firestore.instance.collection(str).orderBy('title').snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) return Container();
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none)
            return Center(child: CircularProgressIndicator());

          return Container(
            height: 250,
            width: double.infinity,
            child: OrientationBuilder(builder: (context, orientation) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  Movie movieItem = Movie(
                      rate: snapshot.data.documents[index]['rate'] == null
                          ? 0
                          : snapshot.data.documents[index]['rate'],
                      peopleRated:
                          snapshot.data.documents[index]['peopleRated'] == null
                              ? 1
                              : snapshot.data.documents[index]['peopleRated'],
                      rates: snapshot.data.documents[index]['rates'] == null
                          ? {}
                          : snapshot.data.documents[index]['rates'],
                      adult: snapshot.data.documents[index]['adult'],
                      voteAverage: snapshot
                          .data.documents[index]['vote_average']
                          .toDouble(),
                      popularity: snapshot.data.documents[index]['popularity']
                          .toDouble(),
                      voteCount: snapshot.data.documents[index]['vote_count'],
                      video: snapshot.data.documents[index]['video'],
                      posterPath: snapshot.data.documents[index]['poster_path'],
                      id: snapshot.data.documents[index]['id'],
                      backdropPath: snapshot.data.documents[index]
                          ['backdrop_path'],
                      docID: snapshot.data.documents[index].documentID,
                      originalLanguage: snapshot.data.documents[index]
                          ['original_language'],
                      originalTitle: snapshot.data.documents[index]
                          ['original_title'],
                      genreIds: snapshot.data.documents[index]['genre_ids'],
                      title: snapshot.data.documents[index]['title'],
                      overview: snapshot.data.documents[index]['overview'],
                      releaseDate: snapshot.data.documents[index]
                          ['release_date']);
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                        width: 200, child: MovieTile(movieItem: movieItem)),
                  );
                },
              );
            }),
          );
        },
      ),
    );
  }
}
