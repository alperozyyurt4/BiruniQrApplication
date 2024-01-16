import 'package:biruni_qr_app/core/constant/login_page_constants.dart';
import 'package:biruni_qr_app/core/func/fetch_lesson.dart';
import 'package:biruni_qr_app/core/func/navigation/push_replacement.dart';
import 'package:biruni_qr_app/core/utility/colors_utility.dart';
import 'package:biruni_qr_app/core/utility/login_page_utility.dart';
import 'package:biruni_qr_app/homepage/home_page_veriables.dart';
import 'package:biruni_qr_app/pages/home_page.dart';
import 'package:biruni_qr_app/pages/login_page.dart';
import 'package:biruni_qr_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

bool isFocusedUserName = false;

bool isFocusedPassword = false;
final tUserName = TextEditingController();

BorderRadius borderRadius = BorderRadius.circular(4);

//* E-mail Text Field
class EmailText extends StatefulWidget {
  const EmailText({super.key});

  @override
  State<EmailText> createState() => _EmailTextState();
}

class _EmailTextState extends State<EmailText> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tUserName,
      keyboardType: TextInputType.emailAddress,
      onTap: () {
        setState(() {
          isFocusedUserName = true;
          isFocusedPassword = false;
        });
      },
      onEditingComplete: () {
        isFocusedUserName = false;
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: isFocusedUserName ? ColorsUtility.iconFocus : ColorsUtility.iconNoFocus,
        ),
        hintText: LoginPageConstants.hintUserName,
        suffixText: LoginPageConstants.hintEmail,
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: ColorsUtility.iconNoFocus),
        ),
        focusColor: ColorsUtility.iconFocus,
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: ColorsUtility.iconFocus,
            style: BorderStyle.solid,
            width: 2.5,
          ),
        ),
      ),
    );
  }
}

//* Password Text Field
final tPassword = TextEditingController();

class PasswordText extends StatefulWidget {
  const PasswordText({super.key});

  @override
  State<PasswordText> createState() => _PasswordTextState();
}

class _PasswordTextState extends State<PasswordText> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tPassword,
      obscureText: true,
      onTap: () {
        setState(() {
          isFocusedPassword = true;
          isFocusedUserName = false;
        });
      },
      onEditingComplete: () {
        isFocusedPassword = false;
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        prefixIcon:
            Icon(Icons.password, color: isFocusedPassword ? ColorsUtility.iconFocus : ColorsUtility.iconNoFocus),
        hintText: LoginPageConstants.hintPassowrd,
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: ColorsUtility.iconNoFocus,
          ),
        ),
        focusColor: ColorsUtility.iconFocus,
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: ColorsUtility.iconFocus,
            style: BorderStyle.solid,
            width: 2.5,
          ),
        ),
      ),
    );
  }
}

//* AppBar Text Zone

class AppBarText extends StatefulWidget {
  const AppBarText({super.key});

  @override
  State<AppBarText> createState() => _AppBarTextState();
}

class _AppBarTextState extends State<AppBarText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsUtility.darkBlue,
      width: scaleFactor(context, 550),
      height: scaleFactor(context, 130),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: LoginPageConstants.bottom25,
        child: Padding(
          padding: LoginPageConstants.bottom15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(LoginPageConstants.appBarTitle, style: LoginStyle.appBarStyleTop(context)),
              Padding(
                padding: LoginPageConstants.top5,
                child: Text(LoginPageConstants.appBarSubTitle, style: LoginStyle.appBarStyleBottom(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//* Error Widget
class LoginErrorWidget extends StatelessWidget {
  const LoginErrorWidget({super.key, this.errorMessage});
  final errorMessage;
  @override
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Giriş Başarısız'),
      content: Text(errorMessage),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tamam'))
      ],
    );
  }
}

//* Login Screen Images (Biruni Logo)
class LoginImage extends StatelessWidget {
  const LoginImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: LoginPageConstants.top5 * 2,
        child: Image.asset('assets/images/logo.png',
            width: MediaQuery.of(context).size.width * 0.4, height: MediaQuery.of(context).size.height * 0.15),
      ),
    );
  }
}

String? selectedRole;

//* Drop Down Menu
class DropMenu extends StatefulWidget {
  const DropMenu({super.key});

  @override
  State<DropMenu> createState() => _DropMenuState();
}

class _DropMenuState extends State<DropMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: DropdownButton(
        underline: Container(
          height: scaleFactor(context, 0),
          width: scaleFactor(context, 0),
          color: ColorsUtility.transP,
        ),
        items: <String>[LoginPageConstants.dropStudent, LoginPageConstants.dropAcademician]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedRole = value;
          });
        },
        hint: Text(
          textAlign: TextAlign.right,
          selectedRole ?? LoginPageConstants.dropStudent,
          style: LoginStyle.dropStyle(context),
        ),
        icon: Padding(
          padding: LoginPageConstants.right5 * 3,
          child: Icon(Icons.school_outlined, color: ColorsUtility.darkBlue, size: scaleFactor(context, 35)),
        ),
      ),
    );
  }
}

//* Giriş Yap Butonu
class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  HomeVariables home = HomeVariables();
  HomePage hmpage = const HomePage();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorsUtility.darkBlue),
      onPressed: () async {
        AuthResult authResult = await AuthService().loginUser(
          userName: tUserName.text,
          password: tPassword.text,
        );
        if (authResult.success) {
          LessonFetcher.fetchLessonsFromFirestore(tUserName.text, context);
          navi(context, const HomePage());
        } else {
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext buildContext) => LoginErrorWidget(
              errorMessage: authResult.errorMessage,
            ),
          );
        }
      },
      child: Text(
        LoginPageConstants.loginButton,
        style: LoginStyle.loginButton(context),
      ),
    );
  }
}

//* Parolamı Unuttum Butonu

class ForgetPassowrd extends StatelessWidget {
  const ForgetPassowrd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          launchUrlString('https://sifre.biruni.edu.tr');
        },
        child: Text(LoginPageConstants.forgetPassword, style: LoginStyle.textButtons(context)),
      ),
    );
  }
}

//* Cihaz Sıfırla Butonu
class ResetDevice extends StatelessWidget {
  const ResetDevice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          launchUrlString('https://ders.biruni.edu.tr/attendance_device_reset.php');
        },
        child: Text(LoginPageConstants.resetDevice, style: LoginStyle.textButtons(context)),
      ),
    );
  }
}
