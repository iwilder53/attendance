import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/navigation/navigators.dart';
import 'package:ghrccst_attendance_app/navigation/routes.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';

class NewStudentScreen extends StatelessWidget {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController rollController = TextEditingController();
  late TextEditingController courseController = TextEditingController();
  late TextEditingController semesterController = TextEditingController();

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
                      hintText: 'Enter Your course',
                      hintStyle: TextStyle(fontSize: 14)),
                  controller: courseController,
                ),
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
                      final register = await Provider.of<StudentProvider>(
                              context,
                              listen: false)
                          .addStudent({
                        "userName": nameController.text,
                        "course": courseController.text.trim(),
                        "semester": semesterController.text,
                        "roll": int.parse(rollController.text)
                      });
                      if (register) {
                        // ignore: use_build_context_synchronously
                        push(context, NamedRoute.loginScreen);
                      }
                    },
                    child: Text('Register Now')),
              ]),
        ),
      ),
    );
  }
}
