import 'package:biruni_qr_app/core/constant/help_page_constant.dart';
import 'package:biruni_qr_app/core/func/navigation/push_replacement.dart';
import 'package:biruni_qr_app/core/utility/colors_utility.dart';
import 'package:biruni_qr_app/custom%20widgets/help_page_custom..dart';
import 'package:biruni_qr_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class HelpPageHome extends StatelessWidget {
  const HelpPageHome({super.key});

  static const String _title = 'SSS';
  static const bool _centeredTitle = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navi(context, const HomePage());

        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            leading: IconButton(
                onPressed: () {
                  navi(context, const HomePage());
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            title: const Text(_title),
            backgroundColor: ColorsUtility.darkBlue,
            centerTitle: _centeredTitle,
          ),
        ),
        body: Column(
          children: [
            HelpListTile(text: HelpPageConstants.title1, subTitleText: HelpPageConstants.subtitle1),
            HelpListTile(text: HelpPageConstants.title2, subTitleText: HelpPageConstants.subtitle2),
            HelpListTile(text: HelpPageConstants.title3, subTitleText: HelpPageConstants.subtitle3),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
