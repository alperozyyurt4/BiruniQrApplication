import 'package:biruni_qr_app/core/utility/colors_utility.dart';
import 'package:biruni_qr_app/homepage/home_page_veriables.dart';
import 'package:biruni_qr_app/pages/index.dart';
import 'package:flutter/material.dart';

//* Help Icon
class HelpHomeIcon extends StatelessWidget {
  const HelpHomeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const HelpPageHome(),
            ));
      },
      icon: const Icon(Icons.help),
    );
  }
}

//* Account Icon
class AccountHomeIcon extends StatelessWidget {
  const AccountHomeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const AccountPage(),
          ),
        );
      },
      icon: const Icon(Icons.person),
    );
  }
}

//* App Bar
class AppBarHome extends StatelessWidget {
  const AppBarHome({
    super.key,
    required this.home,
  });

  final HomeVariables home;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 550,
      height: 130,
      color: ColorsUtility.darkBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //* App bar texts
        children: [
          AppBarText(appBarText: home.appBarText1, appBarFontSize: home.appbarFontSize1),
          AppBarText(appBarText: home.appBarText2, appBarFontSize: home.appbarFontSize1),
        ],
      ),
    );
  }
}

//* App Bar Text
// ignore: must_be_immutable
class AppBarText extends StatelessWidget {
  AppBarText({super.key, required this.appBarText, required this.appBarFontSize});
  String appBarText;
  double appBarFontSize;

  @override
  Widget build(BuildContext context) {
    return Text(appBarText, style: TextStyle(color: ColorsUtility.whiteText, fontSize: appBarFontSize));
  }
}

//* Bottom Bar
class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        margin: const EdgeInsets.only(top: 3),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //*First button (HomePage)
            BottomQrButton(),
            //*Second Button(HistoryPage)
            BottomHistoryButton(),
          ],
        ),
      ),
    );
  }
}

//* Bottom QR Button

class BottomQrButton extends StatelessWidget {
  const BottomQrButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'qrBtn',
      elevation: 0,
      backgroundColor: ColorsUtility.darkBlue?.withOpacity(0.15),
      onPressed: () {},
      label: Row(
        children: [
          _BottomIconContainer(
            icon: Icon(
              Icons.qr_code_outlined,
              color: ColorsUtility.darkBlue,
              size: 30,
            ),
          ),
          Text('QR', style: TextStyle(color: ColorsUtility.darkBlue))
        ],
      ),
    );
  }
}

//* Bottom History Button
class BottomHistoryButton extends StatelessWidget {
  const BottomHistoryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        heroTag: 'btnHistory',
        elevation: 0,
        backgroundColor: ColorsUtility.whiteText,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const HistoryPage(),
              ));
        },
        label: _BottomIconContainer(icon: Icon(Icons.history, color: ColorsUtility.greyIcon, size: 30)));
  }
}

//* Bottom Icon Container
// ignore: must_be_immutable
class _BottomIconContainer extends StatelessWidget {
  _BottomIconContainer({required this.icon});
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(shape: BoxShape.circle, color: ColorsUtility.transP),
      child: icon,
    );
  }
}
