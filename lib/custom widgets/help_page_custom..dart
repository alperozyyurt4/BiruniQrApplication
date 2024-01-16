import 'package:biruni_qr_app/core/utility/help_page_utility.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HelpListTile extends StatelessWidget {
  HelpListTile({
    super.key,
    required this.text,
    required this.subTitleText,
  });
  String text;
  String subTitleText;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.info),
      title: Text(text, style: HelpStyle.titleSize(context)),
      subtitle: Text(subTitleText, style: HelpStyle.subtitleSize(context)),
    );
  }
}
