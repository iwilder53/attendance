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
    bool loginState = await studentProvider.login(
        mailController.text.trim(), passController.text.trim());
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

  final _form = GlobalKey<FormState>(); //for storing form state.

  late TextEditingController mailController = TextEditingController();
  late TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double dw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _form, //assigning key to form

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'email cannot be empty';
                  }
                  if (text.contains(RegExp(r'[0-9]'))) {
                    return "Name cannot contain numbers";
                  }
                  if (!text.split("@")[1].contains('raisoni')) {
                    return "Not a valid Raisoni Email";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Email Address',
                    hintText: 'Enter your Raisoni Mail Address',
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
                  onPressed: () {
                    bool isValid = _form.currentState!.validate();
                    if (!isValid) {
                      return;
                    }

                    Provider.of<LecturesProvider>(context, listen: false)
                        .getCourses();
                    push(context, NamedRoute.registerScreen);
                  },
                  child: const Text('New Student? register here')),
            ],
          ),
        ),
      ),
    );
  }
}
