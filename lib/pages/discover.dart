import 'package:filmgenie/Animations/FadeAnimation.dart';
import 'package:filmgenie/constants/color.dart';
import 'package:filmgenie/models/movieModel.dart';
import 'package:filmgenie/models/user.dart';
import 'package:filmgenie/widgets/movieTileTypeSearch.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserMovies extends StatefulWidget {
  List favourites;
  List watchList;
  User usSearch;
  UserMovies({this.favourites, this.watchList, this.usSearch});
  @override
  _UserMoviesState createState() => _UserMoviesState();
}

class _UserMoviesState extends State<UserMovies> {
  var baseImageUrl = "https://image.tmdb.org/t/p/";

  bool isfav = true;
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
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: <Widget>[
                (widget.usSearch.photoUrl != null)
                    ? CircleAvatar(
                        radius: 42.0,
                        backgroundColor: Colors.red,
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: AppTheme.black2,
                          backgroundImage:
                              NetworkImage(widget.usSearch.photoUrl),
                        ),
                      )
                    : CircleAvatar(
                        radius: 42.0,
                        backgroundColor: Colors.red,
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: AppTheme.black2,
                          child: Text(
                            widget.usSearch.displayName.substring(0, 1),
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${widget.usSearch.displayName}",
                      style: TextStyle(
                          color: Colors.red.withOpacity(.8),
                          fontSize: 22.0,
                          fontFamily: "Proxima Nova",
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.usSearch.email}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontFamily: "Proxima Nova",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              FadeAnimation(
                  0.5,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text((isfav) ? "Favourites" : "WatchList",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontFamily: "Proxima Nova")),
                          ),
                          IconButton(
                            icon: Icon(Icons.sync, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                isfav = !isfav;
                              });
                            },
                          )
                        ],
                      ),
                      FadeAnimation(1.5, con('allMovies')),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget con(String str) {
    List sel = (isfav) ? widget.favourites : widget.watchList;

    sel.removeWhere((element) => element == "");
    return Container(
      height: MediaQuery.of(context).size.height - 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              sel.length.toString() + " movies",
              style: TextStyle(color: Colors.red),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection(str)
                  .orderBy('title')
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none)
                  return Container(
                      child: Center(child: CircularProgressIndicator()));

                return sel.length > 0
                    ? Container(
                        height: 250,
                        width: double.infinity,
                        child:
                            OrientationBuilder(builder: (context, orientation) {
                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (ctx, index) {
                              Movie movieItem = Movie(
                                  rate: snapshot.data.documents[index]['rate'] == null
                                      ? 0
                                      : snapshot.data.documents[index]['rate'],
                                  peopleRated:
                                      snapshot.data.documents[index]['peopleRated'] == null
                                          ? 1
                                          : snapshot.data.documents[index]
                                              ['peopleRated'],
                                  rates: snapshot.data.documents[index]['rates'] == null
                                      ? {}
                                      : snapshot.data.documents[index]['rates'],
                                  adult: snapshot.data.documents[index]
                                      ['adult'],
                                  voteAverage: snapshot
                                      .data.documents[index]['vote_average']
                                      .toDouble(),
                                  popularity: snapshot
                                      .data.documents[index]['popularity']
                                      .toDouble(),
                                  voteCount: snapshot.data.documents[index]['vote_count'],
                                  video: snapshot.data.documents[index]['video'],
                                  posterPath: snapshot.data.documents[index]['poster_path'],
                                  id: snapshot.data.documents[index]['id'],
                                  backdropPath: snapshot.data.documents[index]['backdrop_path'],
                                  docID: snapshot.data.documents[index].documentID,
                                  originalLanguage: snapshot.data.documents[index]['original_language'],
                                  originalTitle: snapshot.data.documents[index]['original_title'],
                                  genreIds: snapshot.data.documents[index]['genre_ids'],
                                  title: snapshot.data.documents[index]['title'],
                                  overview: snapshot.data.documents[index]['overview'],
                                  releaseDate: snapshot.data.documents[index]['release_date']);
                              return (sel.contains(movieItem.id.toString()))
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(300)),
                                          height: 250,
                                          width: 200,
                                          child: MovieTileTypeSearch(
                                              movieItem: movieItem)))
                                  : Container();
                            },
                          );
                        }))
                    : Container(
                        height: MediaQuery.of(context).size.height - 180,
                        child: Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Icon(
                                  MdiIcons.movieEditOutline,
                                  size: 100,
                                  color: Colors.red.withOpacity(.5),
                                ))),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
