import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/api.dart';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';
import 'get_location.dart';

class StudentProvider extends ChangeNotifier {
  late Student student;
  FirebaseAuth auth = FirebaseAuth.instance;

  static List attendance = [];
  /* Student(
      name: 'yash',
      course: 'null',
      lectures: [
        Lecture(attendanceMarked: false, id: '1', name: 'AD &A'),
        Lecture(attendanceMarked: false, id: '2', name: 'DEM')
      ],
      section: 'a',
      semester: '1'); */

  Future<bool> login(int phoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //await preferences.clear();

    //  if (phoneVerified) {
    final loginUrl = Uri.parse('$server/api/user/login');
    try {
      final body = json.encode({"phone": phoneNumber});
      var loginState =
          await (http.post(loginUrl, headers: headers, body: body));
      print(loginState.body);

      final studentData = json.decode(loginState.body);
/*       if (studentData['attendance'].length != 0) {
        for (var i = 0; i < studentData['attendance'].length; i++) {
          attendance.add(studentData['attendance'][i]);
          print(studentData['attendance'][i]);
        }
      } */
      setStudentData(studentData['result']);
      return true;
    } on HttpException catch (e) {
      print(e);
      return false;
    }
    //  }
  }

  codeSent(verificationId, resendToken) async {
    // Update the UI - wait for the user to enter the SMS code
    String smsCode = '111111';

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    //  await auth.signInWithCredential(credential);
  }

  Future<bool> addStudent(Map<String, dynamic> newStudent) async {
    newStudent['course'] = 'Msc Computer science';
    print(newStudent);
    final registerUrl = Uri.parse('$server/api/user/register');

    var _body = jsonEncode(newStudent);
    print(_body);
    var loginState =
        await (http.post(headers: headers, registerUrl, body: _body));
    print(loginState.body);
    final studentData = json.decode(loginState.body)['result'];
    print(studentData);
    //  setStudentData(studentData);
    if (jsonDecode(loginState.body)['success']) {
      return true;
    }
    return false;
  }

  setStudentData(studentData) {
    return student = Student(
        course: studentData['course']['course'] ?? 'msc',
        section: studentData['section'] ?? 'msc-1',
        semester: studentData['course']['semester'] ?? '1st',
        subjects: studentData['course']['subjects'],
        name: studentData['userName'],
        teacher: studentData['teacher'],
        roll: studentData['roll']);
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
