import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final bool success;
  final String? errorMessage;

  AuthResult({required this.success, this.errorMessage});
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Kullanıcı girişi
  Future<AuthResult> loginUser({required String userName, required String password}) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: '$userName@st.biruni.edu.tr',
        password: password,
      );

      // Giriş başarılıysa AuthResult nesnesi ile dön
      return AuthResult(success: true);
    } catch (e) {
      print("Kullanıcı girişi başarısız: $e");
      // Giriş başarısızsa AuthResult nesnesi ile hata mesajını dön
      return AuthResult(success: false, errorMessage: "Kullanıcı adı veya şifre hatalı.");
    }
  }

  // Kullanıcı çıkışı
  Future logout() async {
    await _auth.signOut();
  }

  // Kullanıcının oturum durumunu kontrol etme
  Stream<User?> get user => _auth.authStateChanges();
}
