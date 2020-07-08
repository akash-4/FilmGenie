import 'dart:async';
import '../constants/color.dart';
import './signup_email_page.dart';
import '../slider/slide_item.dart';
import 'package:flutter/material.dart';
import '../models/slide.dart';
import 'login_page.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _current_Page = 0;
  final PageController _page_Controller = PageController(initialPage: 0);
  final double _minimumPadding = 5.0;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_current_Page < 2) {
        _current_Page++;
      } else {
        _current_Page = 0;
      }

      _page_Controller.animateToPage(
        _current_Page,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _page_Controller.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _current_Page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dev_height = MediaQuery.of(context).size.height;
    final dev_width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme.black1,
      body: SafeArea(
        child: Container(
          color: AppTheme.black1,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(height: 5),
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
                ),
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      PageView.builder(
                        controller: _page_Controller,
                        onPageChanged: _onPageChanged,
                        itemCount: slideList.length,
                        itemBuilder: (ctx, i) =>
                            SlideItem(index: i, current_Page: _current_Page),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        elevation: 2,
                        color: AppTheme.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: _minimumPadding * 5,
                                vertical: _minimumPadding * 2),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Proxima Nova",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )),
                        onPressed: () {
                          debugPrint('Register Through Email!');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpEmail()),
                          );
                        }),
                    SizedBox(
                      width: 50,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginState()));
                        },
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                _minimumPadding * 4,
                                _minimumPadding * 4,
                                _minimumPadding * 4,
                                _minimumPadding * 4),
                            child: Center(
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                    color: AppTheme.red,
                                    fontFamily: "Proxima Nova",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 24),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
