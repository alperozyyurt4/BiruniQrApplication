import 'package:biruni_qr_app/historypage/history_page_widgets.dart';

class LessonHistory {
  static List<MyListStyle> tileStyles = [];

  static void addLesson(String lessonName, String lessonDate) {
    MyListStyle newLesson = MyListStyle(lessons: lessonName, date: convertTimestamp(lessonDate));
    tileStyles.add(newLesson);
  }

// Firestore'dan çekilen timestamp'i DateTime'a dönüştüren yardımcı fonksiyon
  static String convertTimestamp(String timestamp) {
    try {
      DateTime dateTime = DateTime.parse(timestamp);
      // İstenilen tarih formatına göre biçimlendirme yapabilirsiniz
      return "${dateTime.day}.${dateTime.month}.${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
    } catch (e) {
      print("Timestamp dönüştürme hatası: $e");
      return "";
    }
  }
}
