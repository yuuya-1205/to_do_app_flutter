import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/model/profile.dart';

class UserRepository {
  static final fireStore = FirebaseFirestore.instance;
  static final userCollection = fireStore.collection('users');

  ///特定のドキュメントの情報を取ってきている。
  static DocumentReference getDocumentRef(String uid) =>
      userCollection.doc(uid);

  /// idが自動生成されるためuidが別になる
  static Future<void> createUser(Profile profile) async {
    await userCollection.add(profile.toMap());
  }

  /// uidを紐づけるために用いている
  static Future<void> setUser(Profile profile) async {
    await userCollection
        .doc(profile.uid)
        .set(profile.toMap(), SetOptions(merge: true));
  }

  /// 自分の情報を取得するロジック。
  static Future<Profile?> fetchMyUser(String myUid) async {
    ///今回はドキュメントidに入っている情報を取得している。
    final snap = await getDocumentRef(myUid).get();

    ///フィールドの情報を取得した。
    final profile = Profile.fromSnap(snap);
    return profile;
  }
}
