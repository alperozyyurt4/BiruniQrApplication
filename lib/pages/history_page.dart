import 'package:biruni_qr_app/core/func/navigation/push_replacement.dart';
import 'package:biruni_qr_app/historypage/history_page_widgets.dart';
import 'package:biruni_qr_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int selectedBottomButtonIndex1 = 0;
  int selectedBottomButtonIndex2 = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navi(context, const HomePage());
        return true;
      },
      child: const Scaffold(
        body: Hscroll(),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomQr(),
              BottomHistory(),
            ],
          ),
        ),
      ),
    );
  }
}
