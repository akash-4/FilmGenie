import 'package:filmgenie/models/movieModel.dart';
import 'package:filmgenie/pages/movieDesc.dart';
import 'package:flutter/material.dart';

class MovieTileType extends StatefulWidget {
  final Movie movieItem;

  MovieTileType({this.movieItem});

  @override
  _MovieTileTypeState createState() => _MovieTileTypeState();
}

class _MovieTileTypeState extends State<MovieTileType> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          height: 300,
          width: 350,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [const Color(0x00000000), const Color(0xD9333333)],
                  stops: [0.0, 0.9],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(0.0, 1.0))),
          child: InkWell(
            onTap: () {
              debugPrint(widget.movieItem.title.toString());

              debugPrint(widget.movieItem.voteCount.toString());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieHome(
                      movieItem: widget.movieItem,
                    ),
                  ));
            },
            child: Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      (widget.movieItem.posterPath != null)
                          ? '${baseImageUrl}w342${widget.movieItem.posterPath}'
                          : 'https://icon-library.com/images/movie-icon-vector/movie-icon-vector-11.jpg',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 250,
                    )),
                Positioned(
                    bottom: 0,
                    child: Container(
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.transparent,
                              Colors.red.withOpacity(.3)
                            ],
                                stops: [
                              0.0,
                              0.9
                            ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(0.0, 1.0))),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
                            child: Text(
                              widget.movieItem.title,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
