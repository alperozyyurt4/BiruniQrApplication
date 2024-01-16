import 'package:biruni_qr_app/core/func/navigation/push_replacement.dart';
import 'package:biruni_qr_app/core/utility/colors_utility.dart';
import 'package:biruni_qr_app/custom%20widgets/index.dart';
import 'package:biruni_qr_app/historypage/history_page_utility.dart';
import 'package:biruni_qr_app/historypage/lesson_history.dart';
import 'package:biruni_qr_app/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Hscroll extends StatefulWidget {
  const Hscroll({super.key});

  @override
  _HscrollState createState() => _HscrollState();
}

class _HscrollState extends State<Hscroll> {
  bool sorted = false;
  String userName = tUserName.text;
  final CollectionReference _historyCollection = FirebaseFirestore.instance.collection('students');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: historyScrollView(),
    );
  }

  Widget historyScrollView() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
            onPressed: () {
              // Tıklanıldığında sıralama işlemi yap

              // Tersine çevir ve sayfayı yenile
              setState(() {
                sorted = !sorted;
              });
            },
            icon: const Icon(Icons.list),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDeleteConfirmationDialog(context);
              },
              icon: const Icon(Icons.delete),
              padding: const EdgeInsets.only(right: 5),
            )
          ],
          expandedHeight: MediaQuery.of(context).size.height * 0.18,
          pinned: true,
          backgroundColor: ColorsUtility.darkBlue,
          flexibleSpace: const FlexibleSpaceBar(
            centerTitle: true,
            title: Text('Geçmiş'),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              // Tarih sıralamasına göre indeks belirle
              int sortedIndex = sorted ? index : LessonHistory.tileStyles.length - 1 - index;
              return LessonHistory.tileStyles[sortedIndex].build(context);
            },
            childCount: LessonHistory.tileStyles.length,
          ),
        )
      ],
    );
  }

  void deleteHistory() async {
    try {
      QuerySnapshot querySnapshot = await _historyCollection.doc(userName).collection('yoklamalar').get();

      for (QueryDocumentSnapshot userDoc in querySnapshot.docs) {
        CollectionReference attendanceCollection = userDoc.reference.collection('yoklamalar');
        QuerySnapshot attendanceSnapshot = await attendanceCollection.get();

        for (QueryDocumentSnapshot attendanceDoc in attendanceSnapshot.docs) {
          await attendanceDoc.reference.delete();
        }

        await userDoc.reference.delete();
      }

      // Local listeyi temizle
      setState(() {
        LessonHistory.tileStyles.clear();
      });

      // İsteğe bağlı olarak, silme işleminden sonra ana sayfaya geri dönülebilir
      // pushReplacement(context, HomePage());
    } catch (e) {
      print("Geçmişi silme hatası: $e");
      // Hata varsa burada işleyebilirsiniz
    }
  }

  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bilgilendirme'),
          content: const Text('Ders geçmişinizi silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Kapat butonuna basılınca dialog kapanır.
              },
              child: const Text('Vazgeç'),
            ),
            TextButton(
              onPressed: () {
                deleteHistory();
                Navigator.of(context).pop(); // Kapat butonuna basılınca dialog kapanır.
              },
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }
}
//* List Tile Style

class MyListStyle {
  final String lessons;
  final String date;

  MyListStyle({required this.lessons, required this.date});

  ListTile build(BuildContext context) {
    return ListTile(
      title: Text(
        lessons,
        style: HistoryStyle.lessonStyle(context),
      ),
      subtitle: Text(
        date,
        style: HistoryStyle.dateStyle(context),
      ),
    );
  }
}

//* Bottom History Button
class BottomHistory extends StatelessWidget {
  const BottomHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        heroTag: 'historyBtn1',
        elevation: 0,
        backgroundColor: ColorsUtility.darkBlue?.withOpacity(0.15),
        onPressed: () {},
        label: Row(
          children: [
            BottomIconContainer(icon: Icon(Icons.history, color: ColorsUtility.darkBlue, size: 30)),
            Text(
              'Geçmiş',
              style: TextStyle(color: ColorsUtility.darkBlue),
            )
          ],
        ));
  }
}

//* Bottom QR Button
class BottomQr extends StatelessWidget {
  const BottomQr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        heroTag: 'qrBtn1',
        backgroundColor: ColorsUtility.whiteText,
        elevation: 0,
        onPressed: () {
          navi(context, const HomePage());
        },
        label: BottomIconContainer(icon: Icon(Icons.qr_code_outlined, color: ColorsUtility.greyIcon, size: 30)));
  }
}
//* Bottom Container

// ignore: must_be_immutable
class BottomIconContainer extends StatelessWidget {
  BottomIconContainer({super.key, required this.icon});
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
