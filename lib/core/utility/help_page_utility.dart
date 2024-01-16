import 'package:flutter/material.dart';

class HelpStyle {
  HelpStyle._();

  static double _textScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  static TextStyle titleSize(BuildContext context) => TextStyle(
        fontSize: 18 * _textScaleFactor(context),
      );
  static TextStyle subtitleSize(BuildContext context) => TextStyle(
        fontSize: 16 * _textScaleFactor(context),
      );
}
