import 'package:flutter/material.dart';

import '../modules/level.dart';
import '../constants.dart';

List<Level> levels = [
  Level(title: "True or False", description: "Let's start the true false questions", image: "assets/images/bags.png", levelText: "Level 1", levelStatusIcon: Icons.play_arrow, colors: [kL1, kL12],),
  Level(title: "Multi Choice", description: "Let's start the multi choice questions", image: "assets/images/ballon-s.png", levelText: "Level 2", levelStatusIcon: Icons.lock, colors: [kL2, kL22] ),
];
