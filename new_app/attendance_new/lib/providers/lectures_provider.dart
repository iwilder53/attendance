import 'dart:convert';
import 'dart:io';
import 'package:attendance_new/providers/student_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:csv/csv.dart';
import '../api.dart';
import '../models/lecture_model.dart';

import 'get_location.dart';

class LecturesProvider extends ChangeNotifier {
  late StudentProvider student;
  List<Lecture> presentDay = [];
  List<List<Lecture>> wholeWeek = [];
  List courses = [];
  bool resultAwaiting = false;

  fetchAndSetLectures(StudentProvider student) async {
    this.student = student;
    Uri timetableUri = Uri.parse('$server/api/timetable/gettimetable');
    final body = {
      "course": student.student.course,
      "semester": student.student.semester.toString()
    };
    var response = await http.post(timetableUri, body: body);

    final jsonResult = json.decode(response.body);
    if (kDebugMode) {
      print(jsonResult);
    }

    for (var i = 0; i < jsonResult.length; i++) {
      if (jsonResult["result"][i]["day"] ==
          //  getWeekDay(DateTime.now().weekday)) {
          "tuesday") {
        for (var lecture in jsonResult["result"][i]["lectures"]) {
          if (lecture["subject"] != "" &&
              lecture["subject"].toString().toLowerCase() != "break") {
            presentDay.add(
                Lecture(subject: lecture["subject"], time: lecture["time"]));
            if (kDebugMode) {
              print(presentDay);
            }
          }
        }
      }
    }

    if (presentDay.isNotEmpty) {
      presentDay.sort((a, b) => a.time.compareTo(b.time));
    }
    //  print(presentDay[3].subject);
    return presentDay;
  }

  saveToDevice(int index) async {
    final prefs = await SharedPreferences.getInstance();

    final savedData = await prefs.setString(
        'presentDay$index', json.encode(presentDay[index].toJson()));
    if (kDebugMode) {
      print(savedData);
    }
  }

  getPresentDay() async {
    final prefs = await SharedPreferences.getInstance();
    final index = student.student.subjects.length;

    if (kDebugMode) {
      print('i:$index');
    }

    for (num i = 0; i < index; i++) {
      if (kDebugMode) {
        print(prefs.getString('presentDay$i'));
      }
      try {
        final jsonData = prefs.getString('presentDay$i');

        //bool clear = await prefs.clear();
        if (jsonData != null) {
          presentDay.removeWhere((element) =>
              element.subject ==
              Lecture.fromJson(json.decode(jsonData)).subject);
          presentDay.add(Lecture.fromJson(json.decode(jsonData)));
          //  presentDay = sortList(presentDay);
          if (presentDay.isNotEmpty) {
            presentDay.sort((a, b) => a.subject.compareTo(b.subject));
            // presentDay = sortList(presentDay);
          }
        }

        //  prefs.remove('presentDay$i');
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        break;
      }
    }
  }

  createAttendance(String subject) async {
    resultAwaiting = true;
    notifyListeners();
    final location = await determinePosition();
    double longitude = location.longitude;
    double latitude = location.latitude;

    Uri timetableUri = Uri.parse('$server/api/user/generateAttendance');
    final body = {
      "roll": student.student.roll.toString(),
      "subject": subject,
      "locationLng": longitude.toString(),
      "locationLat": latitude.toString()
    };
    if (kDebugMode) {
      print(body.toString());
    }
    var response =
        await http.post(timetableUri, body: jsonEncode
        (body), headers: headers);

    final jsonResult = json.decode(response.body);
    if (kDebugMode) {
      print(jsonResult['attendance']);
    }
    resultAwaiting = false;
    notifyListeners();
    return jsonResult['attendance'];
  }

  markPresentDay(index) async {
    final response = await student.markAttendance(index);

    final json = jsonDecode(response.body);

    if (kDebugMode) {
      print(presentDay);
    }

    index = presentDay.firstWhere((element) =>
        element.subject == index.split('.')[1].toString().toUpperCase());

    index = presentDay.indexOf(index);
    if (kDebugMode) {
      print(index);
    }
    presentDay[index].id = json["_id"] ?? 'null';
    presentDay[index].marked = true;

    notifyListeners();
    if (json['success'] == true) {
      return true;
    } else {
      return false;
    }
  }

  getCourses() async {
    Uri getCoursesUri = Uri.parse('$server/api/course/getcourses');

    var response = await http.get(getCoursesUri);

    final jsonResult = json.decode(response.body);
    if (kDebugMode) {
      print(jsonResult['result']);
    }
    return courses = jsonResult['result'];
  }

  List<List<Lecture>> daysTimetable = [[]];
  uploadTimetable(String timetablePath) async {
    final input = File(timetablePath).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    if (kDebugMode) {
      print(fields);
    }
    for (int i = 1; i < fields.length; i++) {
      daysTimetable.add([]);
    }
    for (var v = 1; v < fields.length; v++) {
      for (var i = 1; i < fields[0].length; i++) {
        daysTimetable[v].add(Lecture(
            subject: fields[v][i], time: fields[0][i], day: fields[v][0]));
      }
    }
    var timetableList;
    for (var i = 0; i < daysTimetable.length; i++) {
      for (var j = 0; j < daysTimetable[i].length; j++) {
        timetableList = daysTimetable[i][j].toJson();
        if (kDebugMode) {
          print(timetableList.toString());
        }
      }
    }
  }
}
