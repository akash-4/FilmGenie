import '../Animations/FadeAnimation.dart';
import './signup_email_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants/color.dart';
import '../services/auth.dart';

class LoginState extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginState> {
  bool togglepassword = true;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';

  bool isloading = false;
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
                      ))),
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
                              padding: EdgeInsets.only(
                                  top: _minimumPadding,
                                  bottom: _minimumPadding),
                              child: Center(
                                child: Text(
                                  "Welcome.",
                                  style: TextStyle(
                                    color: AppTheme.offWhite,
                                    fontSize: 40,
                                    fontFamily: "Proxima Nova",
                                    fontWeight: FontWeight.w700,
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
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              validator: (String value) {
                                                if (value.isEmpty)
                                                  return '    Please Enter a valid Email';
                                                if (!value.contains('@'))
                                                  return '    Please Enter a valid Email';
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
                        (email.isNotEmpty && email.contains('@'))
                            ? FadeAnimation(
                                0.2,
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      bottom: 1,
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
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                                validator: (String value) {
                                                  if (value.isEmpty)
                                                    return '    Please Enter the correct Password';
                                                },
                                                onChanged: (val) {
                                                  setState(
                                                      () => password = val);
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
                                                      if (togglepassword ==
                                                          true)
                                                        setState(() {
                                                          togglepassword =
                                                              false;
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
                                                      color: Colors.white),
                                                  errorStyle: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ))))
                            : Container(),
                        (email.isNotEmpty && email.contains('@'))
                            ? FadeAnimation(
                                0.2,
                                Padding(
                                    padding: EdgeInsets.only(right: 20, top: 2),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        child: Text(
                                          "Forgot Password",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.offWhite,
                                          ),
                                        ),
                                        onTap: () {
                                          debugPrint(
                                              'Forgot Password clicked!!');

                                          var alertStyle = AlertStyle(
                                            animationType:
                                                AnimationType.fromTop,
                                            backgroundColor: AppTheme.black1,
                                            isCloseButton: true,
                                            isOverlayTapDismiss: false,
                                            descStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.black2),
                                            animationDuration:
                                                Duration(milliseconds: 400),
                                            alertBorder: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              side: BorderSide(
                                                color: Colors.red,
                                              ),
                                            ),
                                            titleStyle: TextStyle(
                                              color: Colors.red,
                                            ),
                                          );
                                          if (email == "") {
                                            Alert(
                                              style: alertStyle,
                                              context: context,
                                              type: AlertType.error,
                                              title: "Password Reset",
                                              desc:
                                                  "Please Enter An email Address!!",
                                              buttons: [],
                                            ).show();
                                          } else {
                                            _auth.sendPasswordResetEmail(email);
                                            Alert(
                                              context: context,
                                              style: alertStyle,
                                              type: AlertType.success,
                                              title: "Password Reset",
                                              desc: "Please Check Your Email!!",
                                              buttons: [],
                                            ).show();
                                          }
                                        },
                                      ),
                                    )))
                            : Container(),
                        FadeAnimation(
                          1.1,
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
                                    color: (email.isNotEmpty &&
                                            email.contains('@'))
                                        ? AppTheme.black2.withOpacity(.5)
                                        : AppTheme.black1,
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
                                                'Log In',
                                                style: TextStyle(
                                                    color: AppTheme.red,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              )
                                            : Center(
                                                child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Loading",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ))),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          isloading = true;
                                        });
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          setState(() {
                                            error = 'Incorrect Credentials';
                                            isloading = false;
                                          });
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
                                    }),
                              ))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.3,
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
                            1.7,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: devWidth * .1,
                                  height: 2,
                                  color: AppTheme.black2,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: _minimumPadding,
                                        bottom: _minimumPadding),
                                    child: Center(
                                      child: Text(
                                        "Log In with",
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
                                  color: AppTheme.black2,
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.8,
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
                            1.7,
                            Padding(
                                padding: EdgeInsets.only(
                                    top: _minimumPadding * 8,
                                    bottom: _minimumPadding),
                                child: Center(
                                  child: Text(
                                    "New to FilmGenie?",
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
                                          'Sign Up',
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
                                                  SignUpEmail()));
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
