import 'package:filmgenie/Animations/FadeAnimation.dart';
import 'package:filmgenie/constants/color.dart';
import 'package:filmgenie/models/movieModel.dart';
import 'package:filmgenie/widgets/movieTileType.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyMovie extends StatefulWidget {
  final String type;
  final String mType;
  MyMovie({this.mType, this.type});
  @override
  _MyMovieState createState() => _MyMovieState();
}

class _MyMovieState extends State<MyMovie> {
  var baseImageUrl = "https://image.tmdb.org/t/p/";
  String filter;
  String genre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black1,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.red,
                  size: 15,
                ),
                SizedBox(
                  width: 1,
                ),
                Text("Back")
              ],
            ),
          ),
        ),
        backgroundColor: AppTheme.black1,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black26),
        title: Text("FilmGenie",
            style: TextStyle(
                fontFamily: "Proxima Nova",
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          FadeAnimation(
              0.5,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.type,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontFamily: "Proxima Nova")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                onChanged: (val) {
                                  setState(() {
                                    filter = val;
                                    genre = val;
                                  });
                                },
                                value: filter,
                                iconEnabledColor: Colors.red,
                                hint: Text(
                                  ' Filter',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                dropdownColor: AppTheme.black2,
                                isDense: true,
                                style: TextStyle(color: Colors.red),
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                        (filter != 'clear')
                                            ? ' Clear'
                                            : 'Filter',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: (filter != 'clear')
                                                ? AppTheme.offWhite
                                                : AppTheme.black2)),
                                    value: "clear",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Action',
                                        style: TextStyle(fontSize: 14)),
                                    value: '28',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Adventure',
                                        style: TextStyle(fontSize: 14)),
                                    value: '12',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Animation',
                                        style: TextStyle(fontSize: 14)),
                                    value: '16',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Comedy',
                                        style: TextStyle(fontSize: 14)),
                                    value: '35',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Crime',
                                        style: TextStyle(fontSize: 14)),
                                    value: '80',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Documentary',
                                        style: TextStyle(fontSize: 14)),
                                    value: '99',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Drama',
                                        style: TextStyle(fontSize: 14)),
                                    value: '18',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Family',
                                        style: TextStyle(fontSize: 14)),
                                    value: '10751',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Fantasy',
                                        style: TextStyle(fontSize: 14)),
                                    value: '14',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' History',
                                        style: TextStyle(fontSize: 14)),
                                    value: '36',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Horror',
                                        style: TextStyle(fontSize: 14)),
                                    value: '27',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Music',
                                        style: TextStyle(fontSize: 14)),
                                    value: '10402',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Mystery',
                                        style: TextStyle(fontSize: 14)),
                                    value: '9648',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Romance',
                                        style: TextStyle(fontSize: 14)),
                                    value: '10749',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Sci-fi',
                                        style: TextStyle(fontSize: 14)),
                                    value: '878',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Tv Movie',
                                        style: TextStyle(fontSize: 14)),
                                    value: '10770',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Thriller',
                                        style: TextStyle(fontSize: 14)),
                                    value: '53',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' War',
                                        style: TextStyle(fontSize: 14)),
                                    value: '10752',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(' Western',
                                        style: TextStyle(fontSize: 14)),
                                    value: '37',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeAnimation(1.5, con(widget.mType, genre)),
                ],
              )),
        ],
      ),
    );
  }

  Widget con(String str, String g) {
    Stream stream = (g == null || g == 'clear')
        ? Firestore.instance.collection(str).orderBy('title').snapshots()
        : Firestore.instance
            .collection(str)
            .where('genre_ids', arrayContains: int.parse(g))
            .orderBy('title')
            .snapshots();
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) return Container();
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none)
            return Center(child: CircularProgressIndicator());

          return Container(
            height: 350,
            width: double.infinity,
            child: OrientationBuilder(builder: (context, orientation) {
              return GridView.builder(
                itemCount: snapshot.data.documents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio:
                        orientation == Orientation.portrait ? 0.8 : 1,
                    crossAxisCount:
                        orientation == Orientation.portrait ? 2 : 4),
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
                          width: 200,
                          child: MovieTileType(movieItem: movieItem)));
                },
              );
            }),
          );
        },
      ),
    );
  }
}
