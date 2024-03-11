import 'dart:convert';
import 'dart:io';
import 'package:attendance_new/api.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';
import 'get_location.dart';

class StudentProvider extends ChangeNotifier {
  late Student student;

  static List attendance = [];
  String token = '';
  /* Student(
      name: 'yash',
      course: 'null',
      lectures: [
        Lecture(attendanceMarked: false, id: '1', name: 'AD &A'),
        Lecture(attendanceMarked: false, id: '2', name: 'DEM')
      ],
      section: 'a',
      semester: '1'); */

  Future<bool> login(String email, String password) async {
    final loginUrl = Uri.parse('$server/api/user/login');
    try {
      final body = json.encode({"email": email, "pass": password});
      Map<String, String> headers;
      if (token != null) {
        headers = {
          "Content-Type": "application/json; charset=utf-8",
          "accessToken": token
        };
        var loginState =
            await (http.post(loginUrl, headers: headers, body: body));
        print(loginState.body);

        final studentData = json.decode(loginState.body);

        if (studentData['message'] == 'userfound') {
          setStudentData(studentData['result']);
          token = studentData['result']['token'];
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('authMail', email);
          prefs.setString('authPass', password);
          notifyListeners();
          print(token);
          return true;
        }
        return false;
      } else {
        return false;
      }
    } on HttpException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addStudent(Map<String, dynamic> newStudent) async {
    newStudent['course'] = 'Msc Computer Science';

    try {
      final registerUrl = Uri.parse('$server/api/user/register');

      var _body = jsonEncode(newStudent);
      print(_body);
      var loginState =
          await (http.post(headers: headers, registerUrl, body: _body));
      print(loginState.body);
      final studentData = json.decode(loginState.body)['result'];

      print(studentData);
      student = Student.fromJson(studentData);
      if (jsonDecode(loginState.body)['success']) {
        return true;
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
    return false;
  }

  setStudentData(studentData) {
    return student = Student(
        course: studentData['course']['course'] ?? studentData['course'],
        section: studentData['section'] ?? 'msc-1',
        semester: studentData['course']['semester'] ?? '4',
        subjects: studentData['course']['subjects'],
        fname: studentData['firstName'],
        lname: studentData['lastName'],
        token: studentData['token'],
        teacher: studentData['teacher'],
        roll: studentData['roll'] ?? 0);
  }

  markAttendance(id) async {
    try {
      final location = await determinePosition();
      double longitude = location.longitude;

      final attendanceUrl = Uri.parse('$server/api/user/attend');
      final _body = jsonEncode({
        "roll": student.roll,
        "subject": id.split('.')[1],
        "semester": student.semester,
        "course": student.course, // "Msc Computer Science"
        "location": longitude.toString(),
        "id": id.split('.')[0]
      });
      print(_body);
      var result =
          await http.post(headers: headers, attendanceUrl, body: _body);
      print(json.decode(result.body));
      return result;
    } on Exception catch (e) {
      print(e);
    }
  }
}
