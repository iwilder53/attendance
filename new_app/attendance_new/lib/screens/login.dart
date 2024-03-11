// ignore_for_file: use_build_context_synchronously

import 'package:attendance_new/navigation/navigators.dart';
import 'package:attendance_new/navigation/routes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController mailController = TextEditingController();
  late TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Email Address',
                  hintText: 'Enter your Raisoni Mail Adress',
                  hintStyle: TextStyle(fontSize: 14)),
              controller: mailController,
            ),
            TextField(
              obscureText: true,
              obscuringCharacter: '*',
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(fontSize: 14)),
              controller: passController,
            ),
            ElevatedButton(
                onPressed: () async {
                  print('TODO: Implement');
                },
                child: const Text('Log In')),
            TextButton(
                onPressed: () => push(context, NamedRoute.registerScreen),
                child: const Text('New Student? register here')),
          ],
        ),
      ),
    );
  }
}
