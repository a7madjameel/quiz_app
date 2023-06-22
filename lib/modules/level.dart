import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Level {
  String title;
  String description;
  List<Color> colors;
  String levelText;
  String image;
  IconData levelStatusIcon;

  Level({
    required this.title,
    required this.description,
    required this.image,
    required this.levelText,
    required this.colors,
    required this.levelStatusIcon,
  });
}
