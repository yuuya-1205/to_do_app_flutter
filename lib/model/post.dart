import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String userName;
  final String text;
  // final Timestamp createAt;

  Post({
    required this.userName,
    required this.text,
    // this.createAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'text': text,
    };
  }

  static Post fromsnap(QueryDocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data()! as Map<String, dynamic>;
    return Post(
      userName: data['userName'],
      text: data['text'],
    );
  }
}
