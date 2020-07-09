import 'dart:io';
import 'package:filmgenie/Animations/FadeAnimation.dart';
import 'package:filmgenie/constants/color.dart';
import 'package:filmgenie/models/user.dart';
import 'package:filmgenie/pages/userSearch.dart';
import 'package:filmgenie/services/auth.dart';
import 'package:filmgenie/services/filmGenieDb.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future _future;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _editingController;
  bool _isEditingText = false;
  bool visible = true;
  String pUrl = '';
  String pName = '';
  Future fetch() async {
    final user = Provider.of<User>(context, listen: false);
    final DocumentSnapshot userDoc =
        await Firestore.instance.collection('users').document(user.uid).get();
    pUrl = userDoc.data['photoUrl'];
    pName = userDoc.data['displayName'];
    setState(() {
      visible = userDoc.data['visible'];
    });
    if (pName.length > 1)
      setState(() {
        if (user.displayName != pName) user.displayName = pName;
        if (user.photoUrl != pUrl) user.photoUrl = pUrl;
      });
  }

  @override
  void initState() {
    _future = fetch();
    super.initState();
  }

  File _imageFile;
  Future pickImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    var image = await picker.getImage(source: imageSource, imageQuality: 30);
    setState(() {
      _imageFile = File(image.path);
    });
  }

  bool dInfo = false;
  bool isl = false;
  bool vInfo = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: AppTheme.black1,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Form(
                        key: _formKey,
                        child: Stack(
                          children: <Widget>[
                            FadeAnimation(
                              2,
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Center(
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Opacity(
                                          opacity: 0.35,
                                          child: Image.asset(
                                            'assets/images/profile.png',
                                            fit: BoxFit.fill,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1.2,
                                          ),
                                        ))),
                              ),
                            ),
                            Container(
                              child: FutureBuilder(
                                  future: _future,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.waiting ||
                                        snapshot.connectionState ==
                                            ConnectionState.none)
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()))
                                        ],
                                      );
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        FadeAnimation(
                                          0.5,
                                          Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Center(
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    child: (isl)
                                                        ? CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors.red,
                                                          )
                                                        : (user.photoUrl !=
                                                                null)
                                                            ? CircleAvatar(
                                                                radius: 100,
                                                                backgroundColor:
                                                                    AppTheme
                                                                        .black2,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        user.photoUrl))
                                                            : CircleAvatar(
                                                                radius: 100,
                                                                backgroundColor:
                                                                    AppTheme
                                                                        .black2,
                                                                child: Text(
                                                                  user.displayName
                                                                      .substring(
                                                                          0, 1),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          50,
                                                                      fontFamily:
                                                                          "Proxima Nova",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 10,
                                                  right: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      50,
                                                  child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        showDialog(
                                                            context: context,
                                                            child: AlertDialog(
                                                                contentTextStyle:
                                                                    TextStyle(
                                                                        fontFamily:
                                                                            'Proxima Nova'),
                                                                contentPadding: EdgeInsets.only(
                                                                    top: 20,
                                                                    left: 20),
                                                                backgroundColor:
                                                                    AppTheme
                                                                        .black1,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0)),
                                                                content: Text(
                                                                    "Select Method",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        color: Colors
                                                                            .white)),
                                                                titlePadding:
                                                                    EdgeInsets.only(
                                                                        left: 20,
                                                                        top: 20),
                                                                actions: [
                                                                  FlatButton(
                                                                    child: Text(
                                                                      'Camera',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context,
                                                                          true);
                                                                      await pickImage(
                                                                          ImageSource
                                                                              .camera);
                                                                      setState(
                                                                          () {
                                                                        isl =
                                                                            true;
                                                                      });
                                                                      await FilmGenie.startUpload(
                                                                          _imageFile,
                                                                          user.uid);
                                                                      setState(
                                                                          () {
                                                                        isl =
                                                                            false;
                                                                        _future =
                                                                            fetch();
                                                                      });
                                                                    },
                                                                  ),
                                                                  FlatButton(
                                                                    child: Text(
                                                                      'Gallery',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context,
                                                                          true);
                                                                      await pickImage(
                                                                          ImageSource
                                                                              .gallery);
                                                                      setState(
                                                                          () {
                                                                        isl =
                                                                            true;
                                                                      });
                                                                      await FilmGenie.startUpload(
                                                                          _imageFile,
                                                                          user.uid);
                                                                      setState(
                                                                          () {
                                                                        isl =
                                                                            false;
                                                                        _future =
                                                                            fetch();
                                                                      });
                                                                    },
                                                                  ),
                                                                  FlatButton(
                                                                    child: Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              AppTheme.black2),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context,
                                                                          true);
                                                                    },
                                                                  ),
                                                                ]));
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor:
                                                            AppTheme.black1,
                                                        child: CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              AppTheme.black2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Icon(
                                                              Icons.edit,
                                                              size: 10,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        FadeAnimation(1, _editTitleTextField()),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FadeAnimation(
                                            1.5,
                                            Text(
                                              user.email,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Proxima Nova",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FadeAnimation(
                                            1.5,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "Visibility:",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          "Proxima Nova",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      visible = !visible;
                                                      FilmGenie
                                                          .updateProfileVisibility(
                                                              visible,
                                                              user.uid);
                                                    });
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                          border: Border.all(
                                                              color: (visible)
                                                                  ? Colors
                                                                      .greenAccent
                                                                  : Colors.red,
                                                              width: 1)),
                                                      child: Text(
                                                          (visible)
                                                              ? "Public"
                                                              : "Private",
                                                          style: TextStyle(
                                                              color: (visible)
                                                                  ? Colors
                                                                      .greenAccent
                                                                  : Colors.red,
                                                              fontSize: 12))),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  onTap: () {
                                                    setState(() {
                                                      vInfo = !vInfo;
                                                    });
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 2500),
                                                        () {
                                                      setState(() {
                                                        vInfo = !vInfo;
                                                      });
                                                    });
                                                  },
                                                  child: Icon(Icons.info,
                                                      size: 18,
                                                      color: AppTheme.black2
                                                          .withOpacity(.5)),
                                                ),
                                                (vInfo)
                                                    ? Flexible(
                                                        child: Container(
                                                            width: 130,
                                                            child: Text(
                                                                (visible)
                                                                    ? "Other Users can see your favourites and watchlist"
                                                                    : "Other Users can't see your favourites and watchlist",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ))))
                                                    : Container()
                                              ],
                                            )),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        FadeAnimation(
                                            2,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 0,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UserSearch()));
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: Colors.red,
                                                            width: 1)),
                                                    child: Text(
                                                      "Discover",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "Proxima Nova",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      dInfo = !dInfo;
                                                    });
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 2500),
                                                        () {
                                                      setState(() {
                                                        dInfo = !dInfo;
                                                      });
                                                    });
                                                  },
                                                  child: Icon(Icons.info,
                                                      size: 18,
                                                      color: AppTheme.black2
                                                          .withOpacity(.5)),
                                                ),
                                                (dInfo)
                                                    ? Flexible(
                                                        child: Container(
                                                            width: 130,
                                                            child: Text(
                                                                "View Other Users Favourites and WatchList",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ))))
                                                    : Container()
                                              ],
                                            )),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                        ),
                                        FadeAnimation(
                                            2.5,
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 15, bottom: 0),
                                                child: Center(
                                                  child: RaisedButton(
                                                      elevation: 0,
                                                      color: AppTheme.black2
                                                          .withOpacity(.5),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 10),
                                                          child: Text(
                                                            'Sign Out',
                                                            style: TextStyle(
                                                                color: AppTheme
                                                                    .red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18),
                                                          )),
                                                      onPressed: () async {
                                                        showDialog(
                                                            context: context,
                                                            child: AlertDialog(
                                                              title: Text(
                                                                  'Confirm Signout?',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Proxima Nova',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          25,
                                                                      color: Colors
                                                                          .red)),
                                                              actions: [
                                                                FlatButton(
                                                                  child: Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Proxima Nova',
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              AppTheme.offWhite)),
                                                                  onPressed:
                                                                      () async {
                                                                    await AuthService()
                                                                        .deleteToken(
                                                                            user);
                                                                    await AuthService()
                                                                        .signOut();
                                                                    await AuthService()
                                                                        .logout();

                                                                    Navigator.pop(
                                                                        context,
                                                                        true);
                                                                  },
                                                                ),
                                                                FlatButton(
                                                                  child: Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Proxima Nova',
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              AppTheme.black2)),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                              backgroundColor:
                                                                  AppTheme
                                                                      .black1,
                                                            ));
                                                      }),
                                                ))),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _editTitleTextField() {
    final user = Provider.of<User>(context, listen: false);
    if (_isEditingText)
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 8.0, horizontal: MediaQuery.of(context).size.width * 0.2),
        child: Center(
          child: TextFormField(
            cursorColor: Colors.red,
            style: TextStyle(color: Colors.white),
            validator: (String value) {
              if (value.isEmpty) return "Name can't empty";
            },
            decoration: InputDecoration(
                hintText: user.displayName,
                hintStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: Colors.red),
                suffixIcon: FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1),
                            color: Colors.red),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate())
                        _formKey.currentState.save();
                      else
                        new Future.delayed(new Duration(seconds: 1), () {
                          setState(() {
                            _isEditingText = !_isEditingText;
                          });
                        });
                    })),
            keyboardType: TextInputType.text,
            maxLines: 1,
            onSaved: (newValue) {
              setState(() {
                final user = Provider.of<User>(context, listen: false);
                user.displayName = newValue;
                FilmGenie.updateName(user.uid, newValue);
                _isEditingText = false;
              });
            },
            autofocus: true,
            controller: _editingController,
            autocorrect: true,
            textInputAction: TextInputAction.done,
          ),
        ),
      );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 40,
        ),
        Text(
          user.displayName,
          style: TextStyle(
              color: Colors.red,
              fontFamily: "Proxima Nova",
              fontWeight: FontWeight.w700,
              fontSize: 25),
        ),
        SizedBox(
          width: 5,
        ),
        InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                _isEditingText = true;
              });
            },
            child: Container(
              width: 50,
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Icon(
                  Icons.edit,
                  size: 10,
                  color: Colors.white,
                ),
              ),
            ))
      ],
    );
  }
}
