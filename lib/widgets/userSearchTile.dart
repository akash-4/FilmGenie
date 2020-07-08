import 'package:filmgenie/constants/color.dart';
import 'package:filmgenie/models/user.dart';
import 'package:filmgenie/pages/discover.dart';
import 'package:flutter/material.dart';

class UserSearchTile extends StatefulWidget {
  final User usSearch;
  List favourites;
  List watchList;
  UserSearchTile({this.usSearch, this.favourites, this.watchList});

  @override
  _UserSearchTileState createState() => _UserSearchTileState();
}

class _UserSearchTileState extends State<UserSearchTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        color: AppTheme.black2.withOpacity(.5),
        elevation: 0,
        child: ListTile(
          dense: true,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserMovies(
                          usSearch: widget.usSearch,
                          favourites: widget.favourites,
                          watchList: widget.watchList,
                        )));
          },
          leading: (widget.usSearch.photoUrl != null)
              ? CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.red,
                  child: CircleAvatar(
                    radius: 19.0,
                    backgroundColor: AppTheme.black2,
                    backgroundImage: NetworkImage(widget.usSearch.photoUrl),
                  ),
                )
              : CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.red,
                  child: CircleAvatar(
                    radius: 19.0,
                    backgroundColor: AppTheme.black2,
                    child: Text(
                      widget.usSearch.displayName.substring(0, 1),
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
          title: Text(
            "${widget.usSearch.displayName}",
            style: TextStyle(
                color: Colors.red.withOpacity(.8),
                fontSize: 14.0,
                fontFamily: "Proxima Nova",
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${widget.usSearch.email}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontFamily: "Proxima Nova",
            ),
          ),
        ),
      ),
    );
  }
}
