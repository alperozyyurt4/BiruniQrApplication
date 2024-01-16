import 'package:biruni_qr_app/loginpage/login_page_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccPageConstants {
  static String leading1 = 'Ad';
  static String leading2 = 'Soyad';
  static String leading3 = 'Fakülte';
  static String leading4 = 'Bölüm';

  static String trailing1 = '';
  static String trailing2 = '';
  static String trailing3 = '';
  static String trailing4 = '';

  static const String exitText = 'Çıkış Yap';

  static const appBarText = 'Hesap';

  // Firebase bağlantısı ve veri çekme işlemi
  static Future<void> fetchData() async {
    String userName = tUserName.text;
    // Firestore bağlantısı
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Belirli bir koleksiyondan belirli bir belgeyi getirme
    DocumentSnapshot documentSnapshot = await firestore.collection('students').doc(userName).get();

    // Veriyi alma
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    // Veriyi kullanma
    trailing1 = data['name']; // 'your_field' yerine gerçek alan adınızı kullanın
    trailing2 = data['surname'];
    trailing3 = data['fakulte'];
    trailing4 = data['bolum'];
  }
}
