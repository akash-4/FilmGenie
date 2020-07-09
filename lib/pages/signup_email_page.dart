import 'package:flutter/services.dart';

import '../Animations/FadeAnimation.dart';
import '../constants/color.dart';
import './login_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../services/auth.dart';

class SignUpEmail extends StatefulWidget {
  @override
  _SignUpEmailState createState() => new _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String name = '';
  String email = '';
  String password = '';
  bool isloading = false;

  bool togglepassword = true;
  final double _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppTheme.black1,
        resizeToAvoidBottomPadding: false,
        body: Form(
            key: _formKey,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(height: 50),
                  FadeAnimation(
                      0.5,
                      Center(
                        child: Container(
                          height: 40,
                          child: Text("FilmGenie",
                              style: TextStyle(
                                fontFamily: "Proxima Nova",
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.offWhite,
                              )),
                        ),
                      )),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(
                          height: devHeight * 0.04,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          0.7,
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _minimumPadding),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: _minimumPadding * 3,
                                  vertical: _minimumPadding,
                                ),
                                child: Center(
                                  child: Text(
                                    "Join the most happening Movie Community!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.red,
                                      fontSize: (MediaQuery.of(context)
                                                  .size
                                                  .height <
                                              600)
                                          ? MediaQuery.of(context).size.height *
                                              0.032
                                          : 25,
                                      fontFamily: "Proxima Nova",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            0.9,
                            Padding(
                                padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  bottom: 15,
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.red,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Center(
                                          child: TextFormField(
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              validator: (String value) {
                                                if (value.isEmpty)
                                                  return 'Please Enter the Complete Name';
                                              },
                                              onChanged: (val) {
                                                setState(() => name = val);
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Name',
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                errorStyle: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    )))),
                        FadeAnimation(
                            1.1,
                            Padding(
                                padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  bottom: 15,
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.red,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Center(
                                          child: TextFormField(
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              validator: (String value) {
                                                if (value.isEmpty)
                                                  return 'Please Enter correct Email';
                                                if (!value.contains('@'))
                                                  return 'Please Enter correct Email';
                                              },
                                              onChanged: (val) {
                                                setState(() => email = val);
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Email ID',
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                errorStyle: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    )))),
                        FadeAnimation(
                            1.3,
                            Padding(
                                padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  bottom: 0,
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.red,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Padding(
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                            validator: (String value) {
                                              if (value.isEmpty)
                                                return 'Please Enter the correct Password';
                                            },
                                            onChanged: (val) {
                                              setState(() => password = val);
                                            },
                                            obscureText: togglepassword,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.lock,
                                                color: AppTheme.red
                                                    .withOpacity(.0),
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  togglepassword
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: AppTheme.offWhite,
                                                ),
                                                onPressed: () {
                                                  if (togglepassword == true)
                                                    setState(() {
                                                      togglepassword = false;
                                                    });
                                                  else
                                                    setState(() {
                                                      togglepassword = true;
                                                    });
                                                },
                                              ),
                                              border: InputBorder.none,
                                              hintText: 'Password',
                                              hintStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                              errorStyle: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    )))),
                        FadeAnimation(
                          1.6,
                          Padding(
                              padding: EdgeInsets.only(
                                  top: _minimumPadding * 6, bottom: 0),
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    left: devWidth * 0.075,
                                    right: devWidth * 0.075),
                                child: RaisedButton(
                                    elevation: 2,
                                    color: AppTheme.black1,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: AppTheme.red, width: 2),
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: _minimumPadding * 5,
                                            vertical: _minimumPadding * 2),
                                        child: (!isloading)
                                            ? Text(
                                                'Sign Up',
                                                style: TextStyle(
                                                    color: AppTheme.red,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: Colors.white,
                                                ),
                                              )),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          isloading = true;
                                        });
                                        dynamic result = await _auth
                                            .registerWithEmailAndPassword(
                                                email, password, name);
                                        if (result is PlatformException) {
                                          if (result.code ==
                                              'ERROR_EMAIL_ALREADY_IN_USE') {
                                            setState(() {
                                              error = 'Account already exists';
                                              isloading = false;
                                            });
                                          } else if (result.code ==
                                              'ERROR_WEAK_PASSWORD') {
                                            setState(() {
                                              error = 'Weak Password';
                                              isloading = false;
                                            });
                                          } else if (result.code ==
                                              'ERROR_INVALID_EMAIL') {
                                            setState(() {
                                              error = 'Invalid Email';
                                              isloading = false;
                                            });
                                          }
                                        } else {
                                          Navigator.pop(context, true);
                                        }
                                      }
                                      if (error != '') {
                                        AlertDialog alertDialog = AlertDialog(
                                          backgroundColor: AppTheme.black1,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                          title: Text(error,
                                              style: TextStyle(
                                                color: Colors.red,
                                              )),
                                          content: Text("Please try Again!!",
                                              style: TextStyle(
                                                  color: AppTheme.black2)),
                                        );
                                        showDialog(
                                            context: context,
                                            builder: (_) => alertDialog);
                                      }
                                      // Navigator.pop(context, true);
                                    }),
                              ))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.5,
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 0, bottom: _minimumPadding * 3),
                                child: Center(
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                        color: AppTheme.black2,
                                        fontFamily: "Proxima Nova",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ))),
                        FadeAnimation(
                            1.5,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: devWidth * .1,
                                    height: 2,
                                    color: AppTheme.black2),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: _minimumPadding,
                                        bottom: _minimumPadding),
                                    child: Center(
                                      child: Text(
                                        "Sign Up with",
                                        style: TextStyle(
                                            color: AppTheme.black2,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    width: devWidth * 0.1,
                                    height: 2,
                                    color: AppTheme.black2),
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.7,
                            Padding(
                              padding: EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () async {
                                      await _auth.initiateFacebookLogin();
                                      Future.delayed(
                                          const Duration(milliseconds: 3000),
                                          () {
                                        Navigator.pop(context, true);
                                      });
                                    },
                                    color: AppTheme.black2.withOpacity(.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 21,
                                          backgroundColor:
                                              AppTheme.black2.withOpacity(.0),
                                          child: Icon(
                                            MdiIcons.facebook,
                                            color: AppTheme.red,
                                            size: 34,
                                          ),
                                        ),
                                        Text(
                                          'Facebook',
                                          style: TextStyle(
                                              color: AppTheme.red,
                                              fontFamily: "Proxima Nova",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FlatButton(
                                    onPressed: () async {
                                      await _auth.login();
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        Navigator.pop(context, true);
                                      });
                                    },
                                    color: AppTheme.black2.withOpacity(.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 21,
                                          backgroundColor:
                                              AppTheme.black2.withOpacity(.0),
                                          child: Icon(
                                            MdiIcons.google,
                                            color: AppTheme.red,
                                            size: 28,
                                          ),
                                        ),
                                        Text(
                                          'Google',
                                          style: TextStyle(
                                              color: AppTheme.red,
                                              fontFamily: "Proxima Nova",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        FadeAnimation(
                            1.8,
                            Padding(
                                padding: EdgeInsets.only(
                                    top: _minimumPadding * 8,
                                    bottom: _minimumPadding),
                                child: Center(
                                  child: Text(
                                    "Have an Account already?",
                                    style: TextStyle(
                                        color: AppTheme.black2,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ))),
                        FadeAnimation(
                          1.9,
                          Padding(
                              padding: EdgeInsets.only(
                                  top: _minimumPadding, bottom: 0),
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    left: devWidth * 0.075,
                                    right: devWidth * 0.075),
                                child: RaisedButton(
                                    elevation: 0,
                                    color: AppTheme.black2.withOpacity(.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: _minimumPadding * 4,
                                            vertical: _minimumPadding * 2),
                                        child: Text(
                                          'Log In',
                                          style: TextStyle(
                                              color: AppTheme.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        )),
                                    onPressed: () async {
                                      Navigator.pop(context, true);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginState()));
                                    }),
                              ))),
                        ),
                        Container(
                          height: 50.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
