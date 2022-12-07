// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/navigation/navigators.dart';
import 'package:ghrccst_attendance_app/navigation/routes.dart';
import 'package:ghrccst_attendance_app/widgets/alert_dialog.dart';
import 'package:ghrccst_attendance_app/widgets/loader.dart';
import 'package:provider/provider.dart';

import '../providers/lectures_provider.dart';
import '../providers/student_provider.dart';

class LoginScreenDemo extends StatefulWidget {
  const LoginScreenDemo({super.key});

  @override
  State<LoginScreenDemo> createState() => _LoginScreenDemoState();
}

class _LoginScreenDemoState extends State<LoginScreenDemo> {
  FirebaseAuth auth = FirebaseAuth.instance;

  late TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
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
                  bool loginState = await studentProvider
                      .login(int.parse(phoneController.text.trim()));
                  if (loginState == true) {
                    await Provider.of<LecturesProvider>(context, listen: false)
                        .fetchAndSetLectures(Provider.of<StudentProvider>(
                            context,
                            listen: false));
                    pushReplacement(context, NamedRoute.homeScreen);
                  } else {
                    alertDialog(context, 'Login Failed');
                  }
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
