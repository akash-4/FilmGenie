import 'package:filmgenie/constants/color.dart';
import 'package:filmgenie/models/user.dart';
import 'package:filmgenie/widgets/userSearchTile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserSearch extends StatefulWidget {
  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
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
        body: ListView(shrinkWrap: true, children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Discover",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red,
                    fontFamily: "Proxima Nova")),
          ),
          getSearchBar(),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              con(),
            ],
          ),
        ]));
  }

  Widget con() {
    Stream stream = Firestore.instance
        .collection("users")
        .where('visible', isEqualTo: true)
        .orderBy('displayName')
        .snapshots();
    return Container(
      height: MediaQuery.of(context).size.height - 225,
      child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) return Container();
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none)
            return Center(child: CircularProgressIndicator());

          return Container(
            height: MediaQuery.of(context).size.height - 200,
            width: double.infinity,
            child: OrientationBuilder(builder: (context, orientation) {
              return (enteredSearchQuery.toLowerCase().trim().isNotEmpty)
                  ? ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, index) {
                        User usSearch = User(
                          displayName: snapshot.data.documents[index]
                              ['displayName'],
                          email: snapshot.data.documents[index]['email'],
                          photoUrl: snapshot.data.documents[index]['photoUrl'],
                        );
                        List favourites =
                            snapshot.data.documents[index]['favourites'];
                        List watchList =
                            snapshot.data.documents[index]['watchList'];
                        return (usSearch.displayName
                                .toLowerCase()
                                .contains(enteredSearchQuery.toLowerCase()))
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(300)),
                                    width: double.infinity,
                                    child: UserSearchTile(
                                      usSearch: usSearch,
                                      favourites:
                                          favourites == null ? [] : favourites,
                                      watchList:
                                          watchList == null ? [] : watchList,
                                    )),
                              )
                            : Container();
                      },
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, index) {
                        User usSearch = User(
                          displayName: snapshot.data.documents[index]
                              ['displayName'],
                          email: snapshot.data.documents[index]['email'],
                          photoUrl: snapshot.data.documents[index]['photoUrl'],
                        );
                        List favourites =
                            snapshot.data.documents[index]['favourites'];
                        List watchList =
                            snapshot.data.documents[index]['watchList'];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(300)),
                              width: double.infinity,
                              child: UserSearchTile(
                                usSearch: usSearch,
                                favourites:
                                    favourites == null ? [] : favourites,
                                watchList: watchList == null ? [] : watchList,
                              )),
                        );
                      },
                    );
            }),
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
