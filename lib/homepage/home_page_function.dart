import 'package:flutter/material.dart';

Future<dynamic> naviHome(BuildContext context, Widget page) {
  return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
      ));
}
