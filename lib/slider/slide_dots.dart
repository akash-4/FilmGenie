import '../constants/color.dart';
import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.red : AppTheme.offWhite,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class SlideDots_new extends StatelessWidget {
  bool isActive;
  SlideDots_new(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color:
            isActive ?  AppTheme.red : AppTheme.offWhite,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
