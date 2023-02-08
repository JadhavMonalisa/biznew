import 'dart:math';

import 'package:flutter/material.dart';

class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(random.nextInt(300), random.nextInt(300),
        random.nextInt(400), random.nextInt(400));
  }
}
