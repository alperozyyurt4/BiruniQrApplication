import 'package:biruni_qr_app/historypage/lesson_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LessonFetcher {
  static void fetchLessonsFromFirestore(String userName, BuildContext context) async {
    try {
      //* Daha önce eklenen ders bilgilerini temizle
      // ignore: invalid_use_of_protected_member
      ScaffoldMessenger.of(context).setState(() {
        LessonHistory.tileStyles.clear();
      });

      // Firestore bağlantısını al
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      //* Kullanıcının derslerini getir
      DocumentSnapshot studentDocument = await firestore.collection('students').doc(userName).get();
      if (studentDocument.exists) {
        //* Kullanıcının ders bilgilerini al
        List<dynamic> userLessons = studentDocument['lessons'];

        //* Her ders için LessonHistory'e ekle
        for (var lessonData in userLessons) {
          String lessonName = lessonData['ders'];
          Timestamp timestampValue = lessonData['timestamp'];
          String lessonDate = timestampValue.toDate().toString();
          //* Daha önce eklenmemişse ekle
          // ignore: invalid_use_of_protected_member
          ScaffoldMessenger.of(context).setState(() {
            LessonHistory.addLesson(lessonName, lessonDate);
          });
        }
      }
    } catch (e) {
      print('Dersleri alma hatası: $e');
    }
  }
}
