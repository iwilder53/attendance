import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/navigation/navigators.dart';
import 'package:ghrccst_attendance_app/navigation/routes.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  late TextEditingController rollController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Enter roll Number',
                  hintText: 'Enter your id number from your ID card',
                  hintStyle: TextStyle(fontSize: 14)),
              controller: rollController,
            ),
            ElevatedButton(
                onPressed: () async {
                  final login =
                      await Provider.of<StudentProvider>(context, listen: false)
                          .login(rollController.text.trim());
                  if (login) {
                    push(context, NamedRoute.homeScreen);
                  }
                },
                child: Text('Log In')),
            TextButton(
                onPressed: () => push(context, NamedRoute.registerScreen),
                child: const Text('New Student? register here')),
          ],
        ),
      ),
    );
  }
}
