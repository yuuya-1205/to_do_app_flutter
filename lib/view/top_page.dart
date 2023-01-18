import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/model/post.dart';
import 'package:to_do_app/repository/auth_repository.dart';
import 'package:to_do_app/repository/post_repository.dart';
import 'package:to_do_app/view/auth_page/login_page.dart';
import 'package:to_do_app/view/post_page/create_post_page.dart';
import 'package:to_do_app/view/profile_page/profile_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              child: const Icon(Icons.border_all),
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
          title: const Text('ToDoApp'),
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const Text('プロフィール'),
            ),
            GestureDetector(
              onTap: () {
                AuthRepository.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('ログアウト'),
            )
          ],
        )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<Post>>(
                stream: PostRepository.postStream(),
                builder: (BuildContext context,

                    ///snapshotに通信状態が入っている。futureの処理が入っている。
                    AsyncSnapshot<List<Post>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return const Text('エラーが発生しました');

                    ///取得したデータにアクセス
                    ///postsコレクション全ての情報を取ってきている。
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    /// ドキュメント消したら表示されるかチェック
                    /// OK
                    return const Text('ドキュメントがありません');

                    /// データ取得完了している。
                    /// 通信状態を確認するconnectionstate

                  }
                  List<Post> posts = snapshot.data!;
                  return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: posts.map((post) {
                        return Column(
                          children: [
                            Text(post.text),
                            Text(post.id),
                          ],
                        );
                      }).toList());

                  // return ListView(
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   children: docs.map((doc) {
                  //     Map<String, dynamic> data =
                  //         doc!.data() as Map<String, dynamic>;

                  //     ///これがfromsnapの正体
                  //     String text = data['text'];
                  //     return Text(text);
                  //   }).toList(),
                  // );

                  /// データ取得が完了してない場合にくるくるする。
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const CreatePostPage()),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
