import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_app/component/rounded_botton.dart';
import 'package:to_do_app/model/post.dart';
import 'package:to_do_app/repository/post_repository.dart';
import 'package:to_do_app/view/top_page.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _textController = TextEditingController();
  final _userNameContoroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('投稿作成ページ')),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              const Text('ここにToDoを記入してください'),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _userNameContoroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () async {
                  final text = _textController.text;
                  final userName = _userNameContoroller.text;
                  // PostRepository.addPost(
                  //   text,
                  //   postId,
                  // );
                  final post = Post(
                    userName: userName,
                    text: text,
                  );
                  await PostRepository.addPost(post);

                  ///インスタンスを作っている。

                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const TopPage()),
                    ),
                  );
                },
                child: const Text('作成'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
