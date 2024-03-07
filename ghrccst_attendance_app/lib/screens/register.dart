import 'package:flutter/material.dart';
import 'package:attendance_new/navigation/navigators.dart';
import 'package:attendance_new/navigation/routes.dart';
import 'package:attendance_new/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';

class NewStudentScreen extends StatelessWidget {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController rollController = TextEditingController();
  late TextEditingController courseController = TextEditingController();
  late TextEditingController semesterController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('this page is for testing only.'),
                TextField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Name',
                      hintText: 'Enter your full name',
                      hintStyle: TextStyle(fontSize: 14)),
                  controller: nameController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Semester',
                  ),
                  controller: semesterController,
                ),
                TextField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Enter course',
                      hintText: 'Msc Computer Science is defualt for the beta',
                      hintStyle: TextStyle(fontSize: 14)),
                  controller: courseController,
                ),
                TextField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Enter roll Number',
                      hintText: 'Enter your id from your ID card',
                      hintStyle: TextStyle(fontSize: 14)),
                  controller: rollController,
                ),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Password',
                      hintText: 'Select a password',
                      hintStyle: TextStyle(fontSize: 14)),
                  controller: passwordController,
                ),
                TextField(
                  obscureText: true,
                  obscuringCharacter: '#',
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Confirm Password',
                      hintText: 'confrim your password',
                      hintStyle: TextStyle(fontSize: 14)),
                  controller: confirmPasswordController,
                ),
                ElevatedButton(
                    onPressed: passwordController.text.trim() ==
                            confirmPasswordController.text.trim()
                        ? () async {
                            final register = await Provider.of<StudentProvider>(
                                    context,
                                    listen: false)
                                .addStudent({
                              "userName": nameController.text,
                              "course": courseController.text.trim(),
                              "semester": semesterController.text,
                              "roll": int.parse(rollController.text),
                              "password": passwordController.text
                            });
                            if (register) {
                              // ignore: use_build_context_synchronously
                              push(context, NamedRoute.loginScreen);
                            }
                          }
                        : (() => alertDialog(context, 'Passwords Dont Match')),
                    child: const Text('Register Now')),
              ]),
        ),
      ),
    );
  }
}
