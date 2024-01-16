import 'package:biruni_qr_app/core/utility/colors_utility.dart';
import 'package:biruni_qr_app/custom%20widgets/account_page_constants.dart';
import 'package:biruni_qr_app/historypage/lesson_history.dart';
import 'package:biruni_qr_app/homepage/home_page_function.dart';
import 'package:biruni_qr_app/homepage/home_page_veriables.dart';
import 'package:biruni_qr_app/homepage/home_page_widgets.dart';
import 'package:biruni_qr_app/loginpage/login_page_custom.dart';
import 'package:biruni_qr_app/pages/login_page.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeVariables home = HomeVariables();

  bool _controllerInitialized = false;
  //* ignore: unused_field

  // ignore: unused_field
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _fetchDataFromFirestore() async {
    try {
      //* Firestore bağlantısını al
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      //* 'students' koleksiyonundan belirli belgeleri getir
      DocumentSnapshot documentSnapshot = await firestore.collection('students').doc(home.userName).get();
      // Eğer belge bulunamazsa
      if (!documentSnapshot.exists) {
        print('Belge bulunamadı.');
        return;
      }
      // Belgedeki veriyi al
      var name = documentSnapshot['name'];
      var surName = documentSnapshot['surname'];
      var bolumAdi = documentSnapshot['bolum'];

      // State'i güncelle
      setState(() {
        home.appBarText1 = name + " " + surName;
        home.appBarText2 = bolumAdi;
      });
    } catch (e) {
      print('Veri çekme hatası: $e');
    }
  }

  // ignore: unused_field
  late QRViewController _qrController;
  late GlobalKey _qrKey;
  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _qrKey = GlobalKey();
    _fetchDataFromFirestore();
    AccPageConstants.fetchData();
    fetchLessonsFromFirestore(home.userName);
  }

  void _initializeCamera() async {
    home.kameralar = await availableCameras();
    home.controller = CameraController(home.kameralar[0], ResolutionPreset.medium);

    //* Controller'ı başlat
    await home.controller.initialize();

    //* Controller başlatıldığında durumu güncelle
    setState(() {
      _controllerInitialized = true;
    });
  }

  Widget _buildQrScannerWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.54,
      child: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 15,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    String userName = tUserName.text;
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      //* QR kodu tarandığında burası çalışacak
      if (!home.isScanning) {
        String? qrText = scanData.code;

        if (qrText != null) {
          print('QR Kodu Okundu: $qrText');
          _showSnackBar('Yoklama alındı');
          LessonHistory.addLesson(qrText, DateTime.now().toString());
          // Firebase Firestore referansları
          CollectionReference studentsCollection = FirebaseFirestore.instance.collection('students');
          String currentUserName = userName; // Kullanıcının adını buraya yerleştirin
          DocumentReference userDocument = studentsCollection.doc(currentUserName);
          CollectionReference yoklamalarCollection = userDocument.collection('yoklamalar');

          // Belge kimliğini belirleyerek Firestore'e veri ekleme
          yoklamalarCollection.doc(qrText).set({
            'ders': qrText,
            'timestamp': Timestamp.fromDate(DateTime.now()),
          }).then((value) {
            print('Veri Firestore\'a eklendi: $qrText');

            //* İşlem tamamlandığında bayrağı sıfırla
            Future.delayed(const Duration(seconds: 2), () {
              home.isScanning = false;
            });

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }).catchError((error) {
            print('Hata oluştu: $error');
            // Hata durumunda kullanıcıya bilgi verebilir veya başka bir işlem yapabilirsiniz.
          });
        }
      }
    });
  }

  void fetchLessonsFromFirestore(String userName) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Sadece bu kullanıcının Firestore koleksiyonundaki verileri çek
      DocumentSnapshot studentDocument = await firestore.collection('students').doc(userName).get();
      if (studentDocument.exists) {
        CollectionReference yoklamalarCollection = studentDocument.reference.collection('yoklamalar');

        QuerySnapshot yoklamalarSnapshot = await yoklamalarCollection.get();

        for (var lessonDoc in yoklamalarSnapshot.docs) {
          String lessonName = lessonDoc['ders'];
          Timestamp timestampValue = lessonDoc['timestamp'];
          String lessonDate = timestampValue.toDate().toString();

          if (!LessonHistory.tileStyles.any((element) => element.lessons == lessonName)) {
            setState(() {
              LessonHistory.addLesson(lessonName, lessonDate);
            });
          }
        }
      }
    } catch (e) {
      print('Dersleri alma hatası: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    home.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        naviHome(context, const LoginPage());
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(250),
          child: Container(
            child: Column(
              children: [
                AppBar(
                  //*Deleting automatic back buttons
                  automaticallyImplyLeading: false,
                  actions: const [
                    //*Help button
                    Hero(tag: 'helpBtn', child: HelpHomeIcon()),
                    SizedBox(width: 10),
                    //*Account button
                    Hero(tag: 'accountBtn', child: AccountHomeIcon()),
                  ],
                  backgroundColor: ColorsUtility.darkBlue,
                ),
                //* Prepare for appbar Texts
                AppBarHome(home: home)
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio),
              child: Center(
                child: Hero(
                  tag: 'qrScannerBtn',

                  //* QR okutma butonu
                  child: IconButton(
                    onPressed: () {
                      //*After clicked
                      afterClick(context);

                      //*End of the showModal
                    },
                    icon: const Icon(Icons.qr_code_scanner_outlined),
                    iconSize: 165,
                    color: ColorsUtility.darkBlue,
                  ),
                ),
              ),
            ),
            Text('Okutmak için tıklayınız', style: TextStyle(color: ColorsUtility.darkBlue)),
          ],
        ),

        //*Bottom
        bottomNavigationBar: Container(
          child: const BottomBar(),
        ),
      ),
    );
  }

  //* After click QR scan button
  Future<dynamic> afterClick(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SizedBox(
        height: 600,
        child: Column(
          children: [
            //* Gri bar
            Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(color: ColorsUtility.greyIcon, borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(vertical: 10)),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                child: const Text(
                  'QR Kodu Okutun',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Container(
                child: const Text('Qr kodunu belirlenen alana ortalayacak şekilde hizalayın,',
                    style: TextStyle(fontWeight: FontWeight.w300)),
              ),
            ),

            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: _controllerInitialized ? _buildQrScannerWidget() : const CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
