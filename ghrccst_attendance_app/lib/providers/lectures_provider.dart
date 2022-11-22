import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/providers/student_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:csv/csv.dart';
import '../api.dart';
import '../models/lecture_model.dart';

class LecturesProvider extends ChangeNotifier {
  late StudentProvider student;
  List<Lecture> presentDay = [];
  List<List<Lecture>> wholeWeek = [];

  fetchAndSetLectures(StudentProvider student) async {
    this.student = student;
    Uri timetableUri = Uri.parse('$server/api/timetable/gettimetable');
    final body = {
      "course": student.student.course,
      "semester": student.student.semester.toString()
    };
    var response = await http.post(timetableUri, body: body);

    final jsonResult = json.decode(response.body);

    for (var i = 0; i < jsonResult.length; i++) {
      if (jsonResult["result"][i]["day"] ==
          //  getWeekDay(DateTime.now().weekday)) {
          "tuesday") {
        for (var lecture in jsonResult["result"][i]["lectures"]) {
          presentDay
              .add(Lecture(subject: lecture["subject"], time: lecture["time"]));
        }
      }
    }

    if (presentDay.isNotEmpty) {
      presentDay.sort((a, b) => a.time.compareTo(b.time));
    }
    return presentDay;
  }

  saveToDevice(int index) async {
    final prefs = await SharedPreferences.getInstance();

    final savedData = await prefs.setString(
        'presentDay$index', json.encode(presentDay[index].toJson()));
    print(savedData);
  }

  getPresentDay() async {
    final prefs = await SharedPreferences.getInstance();
    final index = student.student.subjects.length;

    print('i:$index');

    for (num i = 0; i < index; i++) {
      print(prefs.getString('presentDay$i'));
      try {
        final jsonData = prefs.getString('presentDay$i');

        //bool clear = await prefs.clear();
        if (jsonData != null) {
          presentDay.removeWhere((element) =>
              element.subject == Lecture.fromJson(json.decode(jsonData)).subject);
          presentDay.add(Lecture.fromJson(json.decode(jsonData)));
          //  presentDay = sortList(presentDay);
          if (presentDay.isNotEmpty) {
            presentDay.sort((a, b) => a.subject.compareTo(b.subject));
            // presentDay = sortList(presentDay);
          }
        }

        //  prefs.remove('presentDay$i');
      } catch (e) {
        print(e);
        break;
      }
    }
  }

  markPresentDay(index) async {
    await student.markAttendance(presentDay[index].subject);
    presentDay[index].marked = true;

    //  print(student.student.subjects.length);
    saveToDevice(index);

    notifyListeners();
  }

  List<List<Lecture>> daysTimetable = [[]];
  uploadTimetable(String timetablePath) async {
    final input = File(timetablePath).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(CsvToListConverter())
        .toList();
    print(fields);
    for (int i = 1; i < fields.length; i++) {
      daysTimetable.add([]);
    }
    for (var v = 1; v < fields.length; v++) {
      for (var i = 1; i < fields[0].length; i++) {
        daysTimetable[v].add(
            Lecture(subject: fields[v][i], time: fields[0][i], day: fields[v][0]));
      }
    }
    var timetableList;
    for (var i = 0; i < daysTimetable.length; i++) {
      for (var j = 0; j < daysTimetable[i].length; j++) {
        timetableList = daysTimetable[i][j].toJson();
        print(timetableList.toString());
      }
    }
  }
}
