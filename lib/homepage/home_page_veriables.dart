import 'package:biruni_qr_app/loginpage/login_page_custom.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class HomeVariables {
  late GlobalKey qrKey;

  String userName = tUserName.text;
  String appBarText1 = '';
  String appBarText2 = '';

  double appbarFontSize1 = 24;
  double appbarFontSize2 = 16;

  bool isScanning = false;

  late CameraController controller;
  late List<CameraDescription> kameralar;
}
