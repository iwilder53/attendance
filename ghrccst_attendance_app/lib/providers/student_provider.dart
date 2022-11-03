import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/api.dart';
import 'package:ghrccst_attendance_app/models/lecture_model.dart';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';

class StudentProvider extends ChangeNotifier {
  final Student student = Student(
      name: 'yash',
      course: 'null',
      lectures: [
        Lecture(attendanceMarked: false, id: '1', name: 'AD &A'),
        Lecture(attendanceMarked: false, id: '2', name: 'DEM')
      ],
      section: 'a',
      semester: '1');

  login() async {
    final loginUrl = Uri.parse('$server/api/user/login');
    final body = json.encode({'name': 'yash', 'id': 2});
    var loginState = await (http.post(loginUrl, body: body));

    final studentData = json.decode(loginState.body);
    print(studentData);

    //TODO: implement login method
    student.name = studentData['result']['userName'];

    //'Yash Bagaria';
    //  student.course =       studentData['result']['course']; // 'Msc. Computer Science';

    print(studentData);
    return studentData;
  }

  void markAttendance(Student student, Lecture lecture) {
    //TODO: implement attendance method
    for (Lecture l in student.lectures) {
      if (l.id == lecture) {
        l.attendanceMarked = true;
      }
    }
  }
}
