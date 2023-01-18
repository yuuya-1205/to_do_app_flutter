import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String text;
  // final Timestamp createAt;

  Post({
    required this.id,
    required this.text,
    // this.createAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
    };
  }

  static Post fromsnap(QueryDocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data()! as Map<String, dynamic>;
    return Post(
      id: data['id'],
      text: data['text'],
    );
  }
}
