// ignore_for_file: use_build_context_synchronously

import 'package:attendance_new/navigation/navigators.dart';
import 'package:attendance_new/navigation/routes.dart';
import 'package:attendance_new/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/lectures_provider.dart';
import '../providers/student_provider.dart';

class LoginScreenDemo extends StatefulWidget {
  const LoginScreenDemo({super.key});

  @override
  State<LoginScreenDemo> createState() => _LoginScreenDemoState();
}

class _LoginScreenDemoState extends State<LoginScreenDemo> {
  bool awaiting = false;
  loaderSwitch() {
    awaiting = !awaiting;
    setState(() {});
  }

  login() async {
    loaderSwitch();
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    bool loginState =
        await studentProvider.login(int.parse(phoneController.text.trim()));
    if (loginState == true) {
      await Provider.of<LecturesProvider>(context, listen: false)
          .fetchAndSetLectures(
              Provider.of<StudentProvider>(context, listen: false));
      pushReplacement(context, NamedRoute.homeScreen);
    } else {
      loaderSwitch();
      alertDialog(context, 'Login Failed');
    }
  }

  late TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double dw = MediaQuery.of(context).size.width;
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
            awaiting
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(dw * 0.01),
                      child: SizedBox(
                        height: dw * 0.1,
                        width: dw * 0.1,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () => login(), child: const Text('Log In')),
            TextButton(
                onPressed: () => push(context, NamedRoute.registerScreen),
                child: const Text('New Student? register here')),
          ],
        ),
      ),
    );
  }
}
