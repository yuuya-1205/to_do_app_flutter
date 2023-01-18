import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_app/component/craft_button.dart';
import 'package:to_do_app/model/profile.dart';
import 'package:to_do_app/repository/auth_repository.dart';
import 'package:to_do_app/repository/user_repository.dart';
import 'package:to_do_app/view/auth_page/register_page.dart';
import 'package:to_do_app/view/top_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('ログイン機能'),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'ログイン',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'パスワード',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final _email = _emailController.text;
                  final _password = _passwordController.text;

                  await AuthRepository.login(
                      email: _email, password: _password);
                  if (AuthRepository.currentFirebaseUser == null) {
                    return;
                  }
                  final uid = AuthRepository.currentFirebaseUser!.uid;

                  final profile = await UserRepository.fetchMyUser(uid);
                  if (profile == null) {
                    return;
                  }
                  Profile.currentProfile = profile;

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const TopPage()),
                    ),
                  );
                },
                child: const Text('ログイン'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const RegisterPage()),
                    ),
                  );
                },
                child: const Text('新規登録'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
