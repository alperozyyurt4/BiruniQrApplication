import 'package:biruni_qr_app/core/constant/login_page_constants.dart';
import 'package:biruni_qr_app/core/func/navigation/push_replacement.dart';
import 'package:biruni_qr_app/core/utility/colors_utility.dart';
import 'package:biruni_qr_app/loginpage/login_page_custom.dart';
import 'package:biruni_qr_app/pages/help_page_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

double scaleFactor(BuildContext context, double value) {
  return value * MediaQuery.of(context).textScaleFactor;
}

class _LoginPageState extends State<LoginPage> {
  BorderRadius borderRadius = BorderRadius.circular(4);
  bool isFocusedUserName = false;
  bool isFocusedPassword = false;
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: Container(
            child: Column(
              children: [
                //* App Bar
                AppBar(
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      onPressed: () {
                        naviRight(context, const HelpPageLogin());
                      },
                      icon: Icon(Icons.help, size: scaleFactor(context, 28)),
                    ),
                  ],
                  backgroundColor: ColorsUtility.darkBlue,
                ),
                const AppBarText(),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView(
                children: [
                  const LoginImage(),
                  Column(
                    children: [
                      Padding(
                        padding: LoginPageConstants.horizontal10,
                        child: const EmailText(),
                      ),
                      Padding(
                        padding: LoginPageConstants.l10t15r10b10,
                        child: const PasswordText(),
                      ),
                    ],
                  ),
                  const DropMenu(),
                  Padding(
                    padding: LoginPageConstants.l10r10t15,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: const LoginButton(),
                    ),
                  ),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: ForgetPassowrd(),
                      ),
                      ResetDevice(),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
