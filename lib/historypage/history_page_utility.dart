import 'package:flutter/material.dart';

class HistoryStyle {
  HistoryStyle._();

  static double _textScaleFactor(BuildContext context, double value) {
    return value * MediaQuery.of(context).textScaleFactor;
  }

  static TextStyle dateStyle(BuildContext context) =>
      TextStyle(fontSize: _textScaleFactor(context, 15), fontWeight: FontWeight.w500, letterSpacing: 0.3);

  static TextStyle lessonStyle(BuildContext context) =>
      TextStyle(fontSize: _textScaleFactor(context, 16), fontWeight: FontWeight.w400, letterSpacing: 0.3);
}
