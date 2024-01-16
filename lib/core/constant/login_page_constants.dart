import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LoginPageConstants {
  LoginPageConstants._();

//* String const

  static const String hintPassowrd = 'Şifre';
  static const String hintEmail = '@st.biruni.edu.tr';
  static const String hintUserName = 'Kullanıcı Adı';
  static const String resetDevice = 'Cihaz Sıfırla';
  static const String loginButton = 'Giriş yap';
  static const String forgetPassword = 'Parolamı Unuttum';
  static const String appBarTitle = 'Biruni Üniversitesi';
  static const String appBarSubTitle = 'Yoklama Sistemi';
  static const String dropStudent = 'Öğrenci';
  static const String dropAcademician = 'Akademisyen';

  static EdgeInsets bottom25 = const EdgeInsets.only(bottom: 25);
  static EdgeInsets bottom15 = const EdgeInsets.only(bottom: 15);
  static EdgeInsets top5 = const EdgeInsets.only(top: 5);
  static EdgeInsets right5 = const EdgeInsets.only(right: 5);
  static EdgeInsets horizontal10 = const EdgeInsets.symmetric(horizontal: 10);
  static EdgeInsets l10t15r10b10 = const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 10);
  static EdgeInsets l10r10t15 = const EdgeInsets.only(left: 10, top: 15, right: 10);
}
