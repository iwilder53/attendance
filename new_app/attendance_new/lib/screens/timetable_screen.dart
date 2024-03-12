import 'dart:convert';
import 'dart:io';
import 'package:attendance_new/providers/student_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:attendance_new/api.dart';
import 'package:attendance_new/providers/lectures_provider.dart';
import 'package:provider/provider.dart';

import '../models/lecture_model.dart';

class TimeTableScreen extends StatelessWidget {
  const TimeTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;
    FilePickerResult? result;

    List<List<Lecture>> daysTimetable = [[]];
    sendTimetable(List<Map<String, dynamic>> timeTable) async {
      Uri timetableUri = Uri.parse('$server/api/timetable/updatetimetable');
      final body = {
        "course":
            Provider.of<StudentProvider>(context, listen: false).student.course,
        "semester": Provider.of<StudentProvider>(context, listen: false)
            .student
            .semester
            .toString(),
        "day": "monday", // timeTable[0]['day'],
        "lectures": timeTable
      };
      if (kDebugMode) {
        print(jsonEncode(body));
      }
      var response = await http.post(timetableUri,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));
      if (kDebugMode) {
        print(json.decode(response.body));
      }
    }

    uploadTimetable(String timetablePath) async {
      final input = File(timetablePath).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();
      for (int i = 1; i < fields.length; i++) {
        daysTimetable.add([]);
      }
      for (var v = 1; v < fields.length; v++) {
        for (var i = 1; i < fields[0].length; i++) {
          daysTimetable[v].add(Lecture(
              subject: fields[v][i], time: fields[0][i], day: fields[v][0]));
        }
      }
      List<Map<String, dynamic>> timetableList = [];
      for (var i = 0; i < daysTimetable.length; i++) {
        for (var j = 0; j < daysTimetable[i].length; j++) {
          timetableList.add(daysTimetable[i][j].toJson());
          if (kDebugMode) {
            print(daysTimetable[i][j].toJson());
          }
        }
      }
      List<Map<String, dynamic>> mondayList = timetableList
          .where((element) => element.containsValue('MON'))
          .toList();

      sendTimetable(mondayList);
    }

    List timeTableData = Provider.of<LecturesProvider>(context).wholeWeek;
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () async {
                result =
                    await FilePicker.platform.pickFiles(allowMultiple: true);
                if (result == null) {
                  if (kDebugMode) {
                    print("No file selected");
                  }
                } else {
                  result?.files.forEach((element) {
                    if (kDebugMode) {
                      print(element.name);
                    }
                    uploadTimetable(element.path!);
                  });
                }
              },
              icon: const Icon(Icons.upload_file_outlined))
        ]),
        body: timeTableData.isEmpty
            ? Padding(
                padding: EdgeInsets.all(dw * 0.2),
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: ((context, index) => const ListTile(
                        title: Text('Nothing uploaded yet'),
                      )),
                ),
              )
            : null);
  }
}
