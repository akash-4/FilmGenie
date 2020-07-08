import 'package:filmgenie/constants/color.dart';
import 'package:filmgenie/models/movieModel.dart';
import 'package:filmgenie/widgets/movieTileTypeSearch.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieSearch extends StatefulWidget {
  @override
  _MovieSearchState createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  var baseImageUrl = "https://image.tmdb.org/t/p/";
  String filter;
  String genre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black1,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
              Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Search",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red,
                            fontFamily: "Proxima Nova")),
                  ),
        Row(children: <Widget>[

       Expanded(child:
          getSearchBar(),),
            Padding(
                      padding: const EdgeInsets.all(0.0),
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
                              'Filter',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            dropdownColor: AppTheme.black2,
                            isDense: true,
                            style: TextStyle(color: Colors.red),
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                    (filter != 'clear') ? 'Clear' : 'Filter',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: (filter != 'clear')
                                            ? AppTheme.offWhite
                                            : AppTheme.black2)),
                                value: "clear",
                              ),
                              DropdownMenuItem(
                                child: Text('Action',
                                    style: TextStyle(fontSize: 14)),
                                value: '28',
                              ),
                              DropdownMenuItem(
                                child: Text('Adventure',
                                    style: TextStyle(fontSize: 14)),
                                value: '12',
                              ),
                              DropdownMenuItem(
                                child: Text('Animation',
                                    style: TextStyle(fontSize: 14)),
                                value: '16',
                              ),
                              DropdownMenuItem(
                                child: Text('Comedy',
                                    style: TextStyle(fontSize: 14)),
                                value: '35',
                              ),
                              DropdownMenuItem(
                                child: Text('Crime',
                                    style: TextStyle(fontSize: 14)),
                                value: '80',
                              ),
                              DropdownMenuItem(
                                child: Text('Documentary',
                                    style: TextStyle(fontSize: 14)),
                                value: '99',
                              ),
                              DropdownMenuItem(
                                child: Text('Drama',
                                    style: TextStyle(fontSize: 14)),
                                value: '18',
                              ),
                              DropdownMenuItem(
                                child: Text('Family',
                                    style: TextStyle(fontSize: 14)),
                                value: '10751',
                              ),
                              DropdownMenuItem(
                                child: Text('Fantasy',
                                    style: TextStyle(fontSize: 14)),
                                value: '14',
                              ),
                              DropdownMenuItem(
                                child: Text('History',
                                    style: TextStyle(fontSize: 14)),
                                value: '36',
                              ),
                              DropdownMenuItem(
                                child: Text('Horror',
                                    style: TextStyle(fontSize: 14)),
                                value: '27',
                              ),
                              DropdownMenuItem(
                                child: Text('Music',
                                    style: TextStyle(fontSize: 14)),
                                value: '10402',
                              ),
                              DropdownMenuItem(
                                child: Text('Mystery',
                                    style: TextStyle(fontSize: 14)),
                                value: '9648',
                              ),
                              DropdownMenuItem(
                                child: Text('Romance',
                                    style: TextStyle(fontSize: 14)),
                                value: '10749',
                              ),
                              DropdownMenuItem(
                                child: Text('Sci-fi',
                                    style: TextStyle(fontSize: 14)),
                                value: '878',
                              ),
                              DropdownMenuItem(
                                child: Text('Tv Movie',
                                    style: TextStyle(fontSize: 14)),
                                value: '10770',
                              ),
                              DropdownMenuItem(
                                child: Text('Thriller',
                                    style: TextStyle(fontSize: 14)),
                                value: '53',
                              ),
                              DropdownMenuItem(
                                child: Text('War',
                                    style: TextStyle(fontSize: 14)),
                                value: '10752',
                              ),
                              DropdownMenuItem(
                                child: Text('Western',
                                    style: TextStyle(fontSize: 14)),
                                value: '37',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                     ],),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
         
      
           
              con('allMovies',genre),
         
        ],
      ),
        ]));
  }

  Widget con(String str,String g) {
     Stream stream = (g == null || g == 'clear')
        ? Firestore.instance.collection(str).orderBy('title').snapshots()
        : Firestore.instance
            .collection(str)
            .where('genre_ids', arrayContains: int.parse(g))
            .orderBy('title')
            .snapshots();
    return Container(
     height: MediaQuery.of(context).size.height-225,
   
      child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) return Container();
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none)
            return Center(child: CircularProgressIndicator());

          return Container(
             height: MediaQuery.of(context).size.height-200,
            width: double.infinity,
            child:OrientationBuilder(
  builder: (context, orientation) {
   
                          return  ( enteredSearchQuery.toLowerCase().trim().isNotEmpty)? ListView.builder(
                itemCount: snapshot.data.documents.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (ctx, index) {
                  Movie movieItem = Movie(
                        rate:  snapshot.data.documents[index]['rate']==null? 0:snapshot.data.documents[index]['rate'],
                       peopleRated:  snapshot.data.documents[index]['peopleRated']==null? 1: snapshot.data.documents[index]['peopleRated'],
                    rates:  snapshot.data.documents[index]['rates']==null? {}: snapshot.data.documents[index]['rates'],
                      adult: snapshot.data.documents[index]['adult'],
                      voteAverage: snapshot.data.documents[index]['vote_average']
                          .toDouble(),
                      popularity:
                          snapshot.data.documents[index]['popularity'].toDouble(),
                      voteCount: snapshot.data.documents[index]['vote_count'],
                      video: snapshot.data.documents[index]['video'],
                      posterPath: snapshot.data.documents[index]['poster_path'],
                      id: snapshot.data.documents[index]['id'],
                      backdropPath: snapshot.data.documents[index]
                          ['backdrop_path'],
                      originalLanguage: snapshot.data.documents[index]
                          ['original_language'],
                      originalTitle: snapshot.data.documents[index]
                          ['original_title'],
                          docID: snapshot.data.documents[index].documentID,
                      genreIds: snapshot.data.documents[index]['genre_ids'],
                      title: snapshot.data.documents[index]['title'],
                      overview: snapshot.data.documents[index]['overview'],
                      releaseDate: snapshot.data.documents[index]
                          ['release_date']);
                    
                  return (movieItem.title.toLowerCase().contains(
                                                  enteredSearchQuery
                                                      .toLowerCase()))? Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 5),
                                                        child: Container(
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(300)),
                                                          height: 250,
                    width: 200,
                    child: MovieTileTypeSearch(movieItem: movieItem)),
                                                      ):Container();
                },
              ):Center(

                    child:     ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
                                          child: Icon(MdiIcons.movieSearchOutline,size: 100,color: Colors.red.withOpacity(.5),)
                                          )               
                                                      );
  }
            ),
          );
        },
      ),
    );
  }
   bool search = false;
  var searchItemController = TextEditingController();
  var enteredSearchQuery = '';
  getSearchBar() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, right: 0),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Container(
            height: 35.0,
            child: TextField(
                textAlign: TextAlign.center,
                cursorColor: Colors.black,
                controller: searchItemController,
                onChanged: (value) {
                  setState(() {
                     enteredSearchQuery = value;
                  });
                   
                },
                style: TextStyle(color: Colors.red),
              
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 50),
                 
                  fillColor: AppTheme.black2,
                  hintText: "Search",
                  filled: true,
                  
                  hintStyle:
                      TextStyle(color: Color(0xFF686969), fontSize: 14.0),
                
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.red),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                )),
          ),
        ),
      ),
    );
  }
}
