import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'getting_started_screen.dart';
import 'home_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return GettingStartedScreen();
    } else {
      return HomeBar();
    }
  }
}
