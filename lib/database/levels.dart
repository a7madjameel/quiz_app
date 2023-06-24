import 'package:flutter/material.dart';

import '../constants.dart';
import '../modules/level.dart';

List<Level> levels = [
  Level(
    title: "True or False",
    description:
        "There you'll challenge one of our most easy true false questions!",
    image: "assets/images/bags.png",
    levelText: "Level 1",
    levelStatusIcon: Icons.play_arrow,
    colors: [kL1, kL12],
  ),
  Level(
      title: "Multiple Choice",
      description:
          "Do you feel confident? There you'll challenge one of our most difficult multiple choices questions",
      image: "assets/images/ballon-s.png",
      levelText: "Level 2",
      levelStatusIcon: Icons.lock,
      colors: [kL2, kL22]),
];
