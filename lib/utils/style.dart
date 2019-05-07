
import 'package:flutter/material.dart';

class myStyle {

  TextStyle getTextStyle(double size, Color color) {
    return new TextStyle(
        color: color,
        fontFamily: 'AmpleSoft',
        package: 'assets/AmpleSoft.otf',
        fontSize: size);
  }
}