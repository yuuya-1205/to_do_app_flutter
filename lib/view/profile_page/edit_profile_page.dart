import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_app/model/profile.dart';
import 'package:to_do_app/repository/user_repository.dart';
import 'package:to_do_app/view/top_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _userIdController = TextEditingController();
  @override
  void initState() {
    _getCurrentProfile();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('プロフィール編集ページ'),
        ),
        body: Column(
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
              child: Text('変更'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Future<void> _getCurrentProfile() async {
    final currentProfile = Profile.currentProfile;

    if (currentProfile == null) {
      return;
    }
    _nameController.text = currentProfile.name;
    _userIdController.text = currentProfile.userId;

    setState(() {});
  }
}
