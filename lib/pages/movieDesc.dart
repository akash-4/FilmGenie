import 'package:filmgenie/Animations/FadeAnimation.dart';
import 'package:filmgenie/constants/color.dart';
import 'package:filmgenie/models/user.dart';
import 'package:filmgenie/services/filmGenieDb.dart';
import 'package:filmgenie/widgets/comments_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as ip;
import '../models/movieModel.dart';

const baseImageUrl = "https://image.tmdb.org/t/p/";

class MovieHome extends StatefulWidget {
  Movie movieItem;
  MovieHome({this.movieItem});
  @override
  _MovieHomeState createState() => new _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black1,
      body: Column(
        children: <Widget>[
          Flexible(
            child: HomeScreeTopPart(
              movieItem: widget.movieItem,
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                HomeScreenBottomPart(
                  movieItem: widget.movieItem,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HomeScreeTopPart extends StatefulWidget {
  Movie movieItem;
  HomeScreeTopPart({this.movieItem});

  @override
  _HomeScreeTopPartState createState() => _HomeScreeTopPartState();
}

class _HomeScreeTopPartState extends State<HomeScreeTopPart> {
  Future _future;

  List favourites = [""];
  List watchList = [""];
  Future fetch() async {
    final user = Provider.of<User>(context, listen: false);
    final DocumentSnapshot userDoc =
        await Firestore.instance.collection('users').document(user.uid).get();
    setState(() {
      favourites = userDoc.data['favourites'];
      watchList = userDoc.data['watchList'];
    });
  }

  @override
  void initState() {
    _future = fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return OrientationBuilder(
      builder: (context, orientation) {
        return new Container(
          height: (orientation == Orientation.portrait) ? 420.0 : 350,
          child: Stack(
            children: <Widget>[
              FadeAnimation(
                  0.8,
                  ClipPath(
                    clipper: Mclipper(),
                    child: Container(
                      height:
                          (orientation == Orientation.portrait) ? 370.0 : 175,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 10.0)
                          ]),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                              '${baseImageUrl}w342${widget.movieItem.posterPath}',
                              fit: BoxFit.cover,
                              width: double.infinity),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  const Color(0x00000000),
                                  const Color(0xD9333333)
                                ],
                                    stops: [
                                  0.0,
                                  0.9
                                ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(0.0, 1.0))),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 45, 8, 25),
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
                                        Text(
                                          "Back",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: (orientation == Orientation.portrait)
                                          ? 120
                                          : 0,
                                      left: 45.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FadeAnimation(
                                          1.5,
                                          Text(
                                            "Watch Now",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                                fontFamily: "Proxima Nova"),
                                          )),
                                      FadeAnimation(
                                          1.5,
                                          Text(
                                            widget.movieItem.title,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: (widget.movieItem
                                                            .title.length >
                                                        20)
                                                    ? 30
                                                    : 45.0,
                                                fontFamily: "Proxima Nova",
                                                fontWeight: FontWeight.w700),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              Positioned(
                top: (orientation == Orientation.portrait) ? 370.0 : 175,
                right: -20.0,
                child: FractionalTranslation(
                  translation: Offset(0.0, -0.5),
                  child: FutureBuilder(
                      future: _future,
                      builder: (ctx, index) {
                        return FadeAnimation(
                            2,
                            Row(
                              children: <Widget>[
                                FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      (favourites.contains(
                                              widget.movieItem.id.toString()))
                                          ? favourites.remove(
                                              widget.movieItem.id.toString())
                                          : favourites.add(
                                              widget.movieItem.id.toString());
                                    });
                                    FilmGenie.updateFavourites(
                                        widget.movieItem.id.toString(),
                                        user.uid);
                                  },
                                  child: Icon(
                                    (favourites.contains(
                                            widget.movieItem.id.toString()))
                                        ? MdiIcons.heart
                                        : MdiIcons.heartOutline,
                                    color: Color(0xFFE52020),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        (watchList.contains(
                                                widget.movieItem.id.toString()))
                                            ? watchList.remove(
                                                widget.movieItem.id.toString())
                                            : watchList.add(
                                                widget.movieItem.id.toString());
                                      });
                                      FilmGenie.updateWatchList(
                                          widget.movieItem.id.toString(),
                                          user.uid);
                                    },
                                    color: Color(0xFFE52020),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 80.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          (watchList.contains(widget
                                                  .movieItem.id
                                                  .toString()))
                                              ? "Added to WatchList"
                                              : "Add to WatchList",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontFamily: "Proxima Nova",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Icon(
                                            (watchList.contains(widget
                                                    .movieItem.id
                                                    .toString()))
                                                ? MdiIcons.formatListChecks
                                                : MdiIcons.formatListCheckbox,
                                            size: 20.0,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ));
                      }),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class HomeScreenBottomPart extends StatefulWidget {
  Movie movieItem;
  HomeScreenBottomPart({this.movieItem});

  @override
  _HomeScreenBottomPartState createState() => _HomeScreenBottomPartState();
}

class _HomeScreenBottomPartState extends State<HomeScreenBottomPart> {
  bool _isAddingText = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _addingController;

  Future _future;

  String usID;
  Future fetch() async {
    final QuerySnapshot userDoc = await Firestore.instance
        .collection('allMovies')
        .where('id', isEqualTo: widget.movieItem.id)
        .getDocuments();
    setState(() {
      usID = userDoc.documents[0].documentID.toString();
    });
  }

  Future _futureRate;
  int people = 1;
  int total = 0;
  int rat = 0;
  Map<String, dynamic> rating = {};
  Future fetchRate() {
    getdata();
  }

  getdata() async {
    final QuerySnapshot userDoc = await Firestore.instance
        .collection('allMovies')
        .where('id', isEqualTo: widget.movieItem.id)
        .getDocuments();
    setState(() {
      widget.movieItem.rates = userDoc.documents[0]['rates'] == null
          ? {}
          : userDoc.documents[0]['rates'];
      rating = userDoc.documents[0]['rates'] == null
          ? {}
          : userDoc.documents[0]['rates'];
      people = rating.length;
      var values = rating.values;
      total = values.reduce((sum, element) => sum + element);
      print(total);
      rat = (total / people).toInt();
    });
    debugPrint("Alldone");
  }

  @override
  void initState() {
    _future = fetch();
    _futureRate = fetchRate();
    super.initState();
  }

  bool showReviews = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return new Container(
      margin: EdgeInsets.only(left: 65.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeAnimation(
                2.5,
                Text(
                  "Overview",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: "Proxima Nova",
                      color: Colors.red),
                )),
            FadeAnimation(
                2.5,
                Container(
                  child: Text(
                    widget.movieItem.overview,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Proxima Nova",
                        color: Colors.white),
                  ),
                )),
            FadeAnimation(
                2.8,
                Row(
                  children: <Widget>[
                    Text(
                      "Released on: ",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Proxima Nova",
                          color: Colors.red),
                    ),
                    Container(
                      child: Text(
                        ip.DateFormat.yMMMd().format(
                            DateTime.parse(widget.movieItem.releaseDate)),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Proxima Nova",
                            color: Colors.white),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: _futureRate,
                builder: (ctx, index) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                            3,
                            Text(
                              "Rating: ",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Proxima Nova",
                                  color: Colors.red),
                            )),
                        FadeAnimation(
                            3,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                for (var i = 0; i < rat; i++)
                                  Icon(
                                    Icons.star,
                                    color: Colors.red,
                                  ),
                                for (var i = 0; i < 5 - rat; i++)
                                  Icon(
                                    Icons.star_border,
                                    color: Colors.red,
                                  ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    ((total / people))
                                                .toDouble()
                                                .toStringAsFixed(2)
                                                .toString() ==
                                            'NaN'
                                        ? 0.toString() + " "
                                        : ((total / people))
                                                .toDouble()
                                                .toStringAsFixed(2)
                                                .toString() +
                                            " ",
                                    style: TextStyle(
                                      color: AppTheme.black2,
                                    )),
                                Icon(
                                  Icons.person,
                                  color: AppTheme.black2,
                                  size: 20,
                                ),
                                Text(people.toString(),
                                    style: TextStyle(
                                      color: AppTheme.black2,
                                    )),
                              ],
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        (widget.movieItem.rates.containsKey(user.uid))
                            ? FadeAnimation(
                                3.5,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Your Rating: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: "Proxima Nova",
                                          color: Colors.red),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        for (var i = 0;
                                            i <
                                                widget.movieItem.rates[user.uid]
                                                    .toInt();
                                            i++)
                                          Icon(
                                            Icons.star,
                                            color: Colors.red,
                                          ),
                                        for (var i = 0;
                                            i <
                                                5 -
                                                    widget.movieItem
                                                        .rates[user.uid]
                                                        .toInt();
                                            i++)
                                          Icon(
                                            Icons.star_border,
                                            color: Colors.red,
                                          ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget.movieItem.rates
                                                  .remove(user.uid);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18.0),
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  fontFamily: "Proxima Nova",
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                            : FadeAnimation(
                                3.5,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Add Rating: ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: "Proxima Nova",
                                          color: Colors.red),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        for (var i = 1; i <= 5; i++)
                                          InkWell(
                                            onTap: () async {
                                              setState(() {
                                                widget.movieItem
                                                    .rates[user.uid] = i;
                                              });
                                              await FilmGenie.updateRatings(
                                                  widget.movieItem.id
                                                      .toString(),
                                                  user.uid,
                                                  i);
                                              debugPrint("done");
                                              setState(() {
                                                _futureRate = fetchRate();
                                              });
                                            },
                                            child: Icon(
                                              Icons.star_border,
                                              color: Colors.red,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ))
                      ]);
                }),
            FadeAnimation(
                4,
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Reviews:",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      showReviews = !showReviews;
                                    });
                                  },
                                  child: Container(
                                      child: Text(
                                          (showReviews) ? "Hide" : "Show",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Proxima Nova",
                                              fontSize: 15)))),
                            ],
                          ),
                        ),
                        Center(child: _commentTextField()),
                        showReviews
                            ? FutureBuilder(
                                future: _future,
                                builder: (ctx, index) {
                                  return StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('allMovies')
                                        .document(usID)
                                        .collection('comments')
                                        .orderBy('datetime')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) return Container();

                                      return ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            snapshot.data.documents.length,
                                        itemBuilder: (ctx, index) => Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: CommentsTile(
                                            movieItem: widget.movieItem,
                                            commentID: snapshot.data
                                                .documents[index].documentID,
                                            c_isEdited: snapshot.data
                                                .documents[index]['isEdited'],
                                            c_dateTime: snapshot.data
                                                .documents[index]['datetime'],
                                            comment: snapshot.data
                                                .documents[index]['comment'],
                                            c_uid: snapshot
                                                .data.documents[index]['uid'],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                })
                            : Container(),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  Widget _commentTextField() {
    final user = Provider.of<User>(context, listen: false);
    if (_isAddingText)
      return Center(
        child: TextFormField(
          validator: (String value) {
            if (value.isEmpty) return "Comment can't empty";
          },
          cursorColor: Colors.red,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              fillColor: Colors.red,
              errorStyle: TextStyle(color: Colors.red),
              hintText: "Add a Review",
              hintStyle: TextStyle(color: Colors.white),
              suffixIcon: IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    if (_formKey.currentState.validate())
                      _formKey.currentState.save();
                    else
                      new Future.delayed(new Duration(seconds: 1), () {
                        setState(() {
                          _isAddingText = !_isAddingText;
                        });
                      });
                  })),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onSaved: (newValue) {
            setState(() {
              FilmGenie.addComments(widget.movieItem.id, newValue, user.uid);
              _isAddingText = false;
            });
          },
          autofocus: true,
          controller: _addingController,
          autocorrect: true,
          textInputAction: TextInputAction.done,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isAddingText = true;
          });
        },
        child: Container(
            padding: EdgeInsets.fromLTRB(1, 5, 0, 0),
            alignment: Alignment.centerRight,
            child: Text(
              "Add a Review",
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppTheme.black2,
                fontSize: 15.0,
              ),
            )));
  }
}

class Mclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 100.0);

    var controlpoint = Offset(35.0, size.height);
    var endpoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
        controlpoint.dx, controlpoint.dy, endpoint.dx, endpoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
