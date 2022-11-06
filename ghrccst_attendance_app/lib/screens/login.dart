import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/navigation/navigators.dart';
import 'package:ghrccst_attendance_app/navigation/routes.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  login(context) {
    final res = Provider.of<StudentProvider>(context, listen: false)
        .login()
        .then((value) => push(context, NamedRoute.homeScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          TextButton(onPressed: () => login(context), child: Text('Login')),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () => push(context, NamedRoute.registerScreen),
              child: const Text('New Student? register here')),
        ],
      ),
    );
  }
}
