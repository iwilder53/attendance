import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/api.dart';
import 'package:ghrccst_attendance_app/models/lecture_model.dart';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';

class StudentProvider extends ChangeNotifier {
  late Student student;
  List attendance = [];
  /* Student(
      name: 'yash',
      course: 'null',
      lectures: [
        Lecture(attendanceMarked: false, id: '1', name: 'AD &A'),
        Lecture(attendanceMarked: false, id: '2', name: 'DEM')
      ],
      section: 'a',
      semester: '1'); */

  Future<Student> login() async {
    final loginUrl = Uri.parse('$server/api/user/login');
    try {
      final body = json.encode({"name": "yash", "id": 22});
      var loginState =
          await (http.post(loginUrl, headers: headers, body: body));
      print(loginState.body);

      final studentData = json.decode(loginState.body);
      for (var i = 0; i < studentData['attendance'].length; i++) {
        attendance.add(studentData['attendance'][i]);
      }
      setStudentData(studentData['result']);
      return student;
    } on HttpException catch (e) {
      print(e);
      return student;
    }
  }

  Future<bool> addStudent(newStudent) async {
    print(newStudent);
    final registerUrl = Uri.parse('$server/api/user/register');

    var _body = jsonEncode(newStudent);
    print(_body);
    var loginState =
        await (http.post(headers: headers, registerUrl, body: _body));
    print(loginState.body);
    final studentData = json.decode(loginState.body)['result'];
    print(studentData);
    setStudentData(studentData);
    if (jsonDecode(loginState.body)['success']) {
      return true;
    }
    return false;
  }

  setStudentData(studentData) {
    return student = Student(
        course: studentData['course']['course'] ?? 'msc',
        section: studentData['section'] ?? 'msc-1',
        semester: studentData['semester'] ?? '1st',
        lectures: studentData['lectures'] ?? [],
        name: studentData['userName'],
        roll: studentData['roll']);
  }

  void markAttendance(String subjectName) async {
    //TODO: implement attendance method
    final attendanceUrl = Uri.parse('$server/api/user/attend');
    final _body = jsonEncode({
      "roll": student.roll,
      "subject": subjectName,
      "semester": student.semester,
      "course": student.semester // "Msc Computer Science"
    });

    var result = await http.post(headers: headers, attendanceUrl, body: _body);
    
  }

  List<DaysLectures> todaysLectures = [
    DaysLectures(id: '', name: 'DEM', time: DateTime.now()),
    DaysLectures(id: '', name: 'AD & A', time: DateTime.now())
  ];
  fetchAndSetLectures() {}
}
