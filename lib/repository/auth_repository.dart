import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/model/profile.dart';

class AuthRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Profile? currentProfile;

  static Future<dynamic> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      currentFirebaseUser = result.user;
      if (currentFirebaseUser == null) {
        return;
      }
      print(
        ('新規登録完了'),
      );
    } on FirebaseAuthException catch (e) {
      print(
        ('新規登録できませんでした'),
      );
      print(e);
    }
  }

  /// ログインの処理
  static Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      currentFirebaseUser = result.user;
    } on FirebaseAuthException catch (e) {
      print(
        ('ログインできませんでした'),
      );
      print(e);
    }
  }

  static Future<dynamic> signOut() async {
    await _firebaseAuth.signOut();
  }
}
