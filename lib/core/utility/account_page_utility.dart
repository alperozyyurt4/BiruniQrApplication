import 'package:flutter/material.dart';

class AccountStyle {
  AccountStyle._();

  static double _textScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  static TextStyle leadingSize(BuildContext context) => TextStyle(
        fontSize: 18 * _textScaleFactor(context),
      );
  static TextStyle trailingSize(BuildContext context) => TextStyle(
        fontSize: 16 * _textScaleFactor(context),
      );
}
