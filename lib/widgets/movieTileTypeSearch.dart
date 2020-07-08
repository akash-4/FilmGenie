import 'package:filmgenie/Animations/FadeAnimation.dart';
import 'package:filmgenie/models/movieModel.dart';
import 'package:filmgenie/pages/movieDesc.dart';
import 'package:flutter/material.dart';

class MovieTileTypeSearch extends StatefulWidget {
  final Movie movieItem;

  MovieTileTypeSearch({this.movieItem});

  @override
  _MovieTileTypeSearchState createState() => _MovieTileTypeSearchState();
}

class _MovieTileTypeSearchState extends State<MovieTileTypeSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieHome(
                    movieItem: widget.movieItem,
                  ),
                ));
          },
          child: Container(
            child: Row(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      (widget.movieItem.posterPath != null)
                          ? '${baseImageUrl}w342${widget.movieItem.posterPath}'
                          : 'https://icon-library.com/images/movie-icon-vector/movie-icon-vector-11.jpg',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 250,
                    )),
                SizedBox(
                  width: 10,
                ),
                FadeAnimation(
                    0.2,
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Flexible(
                              child: Text(
                            widget.movieItem.title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Proxima Nova",
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          )),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.movieItem.overview.length > 100
                                ? widget.movieItem.overview.substring(0, 100) +
                                    "..."
                                : widget.movieItem.overview,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
