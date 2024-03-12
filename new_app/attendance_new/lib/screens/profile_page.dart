import 'package:attendance_new/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(studentProvider.student.fname),
              Text(studentProvider.student.roll.toString()),
              Text(studentProvider.student.course),
              Text(studentProvider.student.semester.toString()),
              const Text('Page under work ')
            ],
          ),
        ),
      ),
    );
  }
}
