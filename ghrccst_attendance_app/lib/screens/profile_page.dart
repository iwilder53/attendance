import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/providers/student_provider.dart';
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
              Text(studentProvider.student.name),
              Text(studentProvider.student.roll.toString()),
              Text(studentProvider.student.course),
              Text(studentProvider.student.semester.toString()),
              Text('Page under work ')
            ],
          ),
        ),
      ),
    );
  }
}
