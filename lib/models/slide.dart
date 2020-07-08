import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Slide {
  final String imageUrl;
  final String title;
  IconData ico;

  Slide({this.imageUrl, @required this.title, this.ico});
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/image1.png',
    title: 'Stay Updated with all latest Movies.',
  ),
  Slide(
      title: 'Search Movies of any type of Genre.',
      ico: MdiIcons.movieSearchOutline),
  Slide(title: 'Add Movie ratings and reviews.', ico: MdiIcons.commentOutline),
  Slide(
      title: 'Allow other users to view your favourites and watchlist.',
      ico: MdiIcons.formatListCheckbox),
];
