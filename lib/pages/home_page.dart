import 'package:filmgenie/models/user.dart';
import 'package:filmgenie/pages/movies.dart';
import 'package:provider/provider.dart';
import '../constants/color.dart';
import 'fav.dart';
import 'profile.dart';
import '../services/auth.dart';
import 'package:flutter/material.dart';
import "package:circular_bottom_navigation/circular_bottom_navigation.dart";
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'movieSearch.dart';

class HomeBar extends StatefulWidget {
  @override
  _HomeBarState createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  int selectedPos = 0;

  double bottomNavBarHeight = 40;

  List<TabItem> tabItems = List.of([
    new TabItem(MdiIcons.movieOpenOutline, "Movies", Colors.transparent,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
    new TabItem(MdiIcons.movieSearchOutline, "Search", Colors.transparent,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
    new TabItem(MdiIcons.movieEditOutline, "MyZone", Colors.transparent,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
    new TabItem(MdiIcons.account, "Profile", Colors.transparent,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
  ]);

  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.black1,
      appBar: AppBar(
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
        actions: [
          selectedPos != 3
              ? Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () async {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            title: Text('Confirm Signout?',
                                style: TextStyle(
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: Colors.red)),
                            actions: [
                              FlatButton(
                                child: Text('Yes',
                                    style: TextStyle(
                                        fontFamily: 'Proxima Nova',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: AppTheme.offWhite)),
                                onPressed: () async {
                                  await AuthService().deleteToken(user);
                                  await AuthService().signOut();
                                  await AuthService().logout();

                                  Navigator.pop(context, true);
                                },
                              ),
                              FlatButton(
                                child: Text('Cancel',
                                    style: TextStyle(
                                        fontFamily: 'Proxima Nova',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: AppTheme.black2)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            backgroundColor: AppTheme.black1,
                          ));
                    },
                    child:
                        Icon(MdiIcons.power, color: Colors.red.withOpacity(.8)),
                  ),
                )
              : Container(),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            child: bodyContainer(),
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }

  Widget bodyContainer() {
    Widget screen;
    switch (selectedPos) {
      case 0:
        screen = MyMovieApp();
        break;
      case 1:
        screen = MovieSearch();
        break;
      case 2:
        screen = UserMovies();
        break;
      case 3:
        screen = Profile();
        break;
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: screen,
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      circleSize: 45,
      iconsSize: 25,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      selectedIconColor: Colors.red,
      barBackgroundColor: AppTheme.black1,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          this.selectedPos = selectedPos;
          print(_navigationController.value);
        });
      },
    );
  }
}
