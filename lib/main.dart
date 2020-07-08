import 'constants/color.dart';
import 'models/user.dart';
import 'pages/wrapper.dart';
import 'services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: "FilmGenie",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            canvasColor: Colors.white,
            primaryColor: Colors.red,
            accentColor: AppTheme.black2),
        home: Wrapper(),
      ),
    );
  }
}
