import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyHomePage({super.key});

  Future<void> migrateUsers() async {
    try {
      // Firestore'daki kullanıcılar koleksiyonunu al
      QuerySnapshot usersCollection = await _firestore.collection('students').get();

      // Her belgeyi döngüye al
      for (QueryDocumentSnapshot userDoc in usersCollection.docs) {
        // Belgeden e-posta ve şifre bilgisini al
        String email = userDoc['email'];
        String password = userDoc['password'];

        try {
          // Firebase Authentication'a kullanıcı ekleniyor
          await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          print('Yeni kullanıcı oluşturuldu: $email');
        } catch (error) {
          print('Hata oluştu: $error');
        }
      }
    } catch (error) {
      print('Firestore verileri alınırken hata oluştu: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
