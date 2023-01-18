import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_app/model/profile.dart';
import 'package:to_do_app/repository/user_repository.dart';
import 'package:to_do_app/view/top_page.dart';

class ProfileRegisterPage extends StatefulWidget {
  const ProfileRegisterPage({Key? key}) : super(key: key);

  @override
  State<ProfileRegisterPage> createState() => _ProfileRegisterPageState();
}

class _ProfileRegisterPageState extends State<ProfileRegisterPage> {
  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _userIdController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ユーザー登録'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'ユーザー名',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: _userIdController,
                decoration: const InputDecoration(
                  hintText: 'ユーザーID',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final _name = _nameController.text;
                  final _userId = _userIdController.text;
                  final uid = FirebaseAuth.instance.currentUser!.uid;
                  final profile = Profile(
                    name: _name,
                    uid: uid,
                    userId: _userId,
                  );
                  await UserRepository.setUser(profile);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TopPage()));
                },
                child: Text('登録'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
