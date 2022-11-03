import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/main_screen.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  login(context) async {
    final student =
        await Provider.of<StudentProvider>(context, listen: false).login();
    if (student['message'] == 'userfound')
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'HomePage')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          TextButton(onPressed: () => login(context), child: Text('Login'))
        ],
      ),
    );
  }
}
