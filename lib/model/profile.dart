import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String name;
  final String uid;
  final String userId;

  Profile({
    required this.name,
    required this.uid,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'userId': userId,
    };
  }

  static Profile? currentProfile;

  static Profile? fromSnap(DocumentSnapshot snap) {
    if (!snap.exists) {
      return null;
    }
    Map<String, dynamic> data = snap.data()! as Map<String, dynamic>;
    return Profile(
      name: data['name'],
      uid: data['uid'],
      userId: data['userId'],
    );
  }
}
