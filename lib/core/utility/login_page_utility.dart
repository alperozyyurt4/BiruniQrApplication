import 'package:biruni_qr_app/core/utility/colors_utility.dart';
import 'package:flutter/material.dart';

class LoginStyle {
  LoginStyle._();

  static double _textScaleFactor(BuildContext context, double value) {
    return value * MediaQuery.of(context).textScaleFactor;
  }

  static TextStyle textButtons(BuildContext context) => TextStyle(
        color: ColorsUtility.darkBlue,
        fontSize: _textScaleFactor(context, 15),
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      );

  static TextStyle loginButton(BuildContext context) => TextStyle(
        color: ColorsUtility.whiteText,
        fontSize: _textScaleFactor(context, 20),
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
      );

  static TextStyle appBarStyleBottom(BuildContext context) => TextStyle(
        color: ColorsUtility.whiteText,
        fontSize: _textScaleFactor(context, 20),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      );

  static TextStyle appBarStyleTop(BuildContext context) => TextStyle(
        color: ColorsUtility.whiteText,
        fontSize: _textScaleFactor(context, 20),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      );

  static TextStyle dropStyle(BuildContext context) => TextStyle(
        fontSize: _textScaleFactor(context, 20),
        fontWeight: FontWeight.w600,
      );
}
