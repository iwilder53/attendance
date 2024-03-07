// ignore_for_file: use_build_context_synchronously

import 'package:attendance_new/navigation/navigators.dart';
import 'package:attendance_new/navigation/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  hintStyle: TextStyle(fontSize: 14)),
              controller: phoneController,
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
