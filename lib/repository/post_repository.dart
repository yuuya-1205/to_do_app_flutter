import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/post.dart';

class PostRepository {
  static final firestore = FirebaseFirestore.instance;
  static final postCollection = firestore.collection('posts');

  static Future<void> addPost(Post post) async {
    await postCollection.add(post.toMap());
  }

  static Stream<List<Post>> postStream() {
    return postCollection
        .snapshots()
        .map((snap) => snap.docs.map((doc) => Post.fromsnap(doc)).toList());
  }
}
