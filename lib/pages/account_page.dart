import 'package:biruni_qr_app/core/func/navigation/push_replacement.dart';
import 'package:biruni_qr_app/core/utility/account_page_utility.dart';
import 'package:biruni_qr_app/core/utility/colors_utility.dart';
import 'package:biruni_qr_app/custom%20widgets/account_page_constants.dart';
import 'package:biruni_qr_app/pages/home_page.dart';
import 'package:biruni_qr_app/pages/login_page.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    var centeredTitle = true;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: IconButton(
              onPressed: () {
                navi(context, const HomePage());
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          centerTitle: centeredTitle,
          backgroundColor: ColorsUtility.darkBlue?.withOpacity(0.9),
          title: const Text(AccPageConstants.appBarText),
        ),
      ),
      body: Column(
        children: [
          ListTile(
              leading: Text(AccPageConstants.leading1, style: AccountStyle.leadingSize(context)),
              trailing: Text(AccPageConstants.trailing1, style: AccountStyle.trailingSize(context))),
          ListTile(
              leading: Text(AccPageConstants.leading2, style: AccountStyle.leadingSize(context)),
              trailing: Text(AccPageConstants.trailing2, style: AccountStyle.trailingSize(context))),
          ListTile(
              leading: Text(AccPageConstants.leading3, style: AccountStyle.leadingSize(context)),
              trailing: Text(AccPageConstants.trailing3, style: AccountStyle.trailingSize(context))),
          ListTile(
              leading: Text(AccPageConstants.leading4, style: AccountStyle.leadingSize(context)),
              trailing: Text(AccPageConstants.trailing4, style: AccountStyle.trailingSize(context))),
          Container(
            child: TextButton(
                onPressed: () {
                  showLogoutConfirmationDialog(context);
                },
                child: const Text(AccPageConstants.exitText)),
          )
        ],
      ),
    );
  }
}

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Bilgilendirme'),
        content: const Text('Çıkış yapmak istediğinizden emin misiniz? Ders geçmişiniz silinecektir.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Kapat butonuna basılınca dialog kapanır.
            },
            child: const Text('Vazgeç'),
          ),
          TextButton(
            onPressed: () {
              // Buraya çıkış işlemlerinizi ekleyebilirsiniz.
              navi(context, const LoginPage());
            },
            child: const Text('Çıkış Yap'),
          ),
        ],
      );
    },
  );
}
