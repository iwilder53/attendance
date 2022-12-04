import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/providers/lectures_provider.dart';
import 'package:ghrccst_attendance_app/widgets/app_drawer.dart';
import 'package:ghrccst_attendance_app/widgets/qr_dialog.dart';
import 'package:ghrccst_attendance_app/widgets/scanner.dart';
import 'package:ghrccst_attendance_app/widgets/timetable.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'providers/student_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  String? currentSubjectCode;
  String message = '';
  @override
  Widget build(BuildContext context) {
    final studentDetails = Provider.of<StudentProvider>(context);
    final student = studentDetails.student;

    //  bluetoothScanner.startScan();
    //  ScanResult result = bluetoothScanner.getResult();
    double dw = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
            padding: const EdgeInsets.all(26.0),
            child: student.teacher
                ? Column(
                    //  physics: const NeverScrollableScrollPhysics(),
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TimeTable(
                        student: studentDetails,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        'Lectures For The Day',
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                        height: student.subjects.length * (dw * 0.15),
                        child: ListView.builder(
                            itemCount: student.subjects.length,
                            itemBuilder: (ctx, idx) => ListTile(
                                  leading: const Icon(Icons.checklist),
                                  title: Text(student.subjects[idx]),
                                  trailing: IconButton(
                                    icon:
                                        Icon(Icons.arrow_circle_right_outlined),
                                    onPressed: () async => {
                                      currentSubjectCode =
                                          await Provider.of<LecturesProvider>(
                                                  context,
                                                  listen: false)
                                              .createAttendance(
                                                  student.subjects[idx]),
                                      message = '$currentSubjectCode.' +
                                          student.subjects[idx],
                                      print(message),
                                      await qrDialog(
                                          context,
                                          '$currentSubjectCode.' +
                                              student.subjects[idx],
                                          dw)
                                    },
                                  ),
                                )),
                      ),
                    ],
                  )),
        floatingActionButton: !student.teacher
            ? ElevatedButton(
                child: const Text('Scan Attendance'),
                onPressed: () => scanQR(
                    context, 'Scan to mark attendance', dw, studentDetails))
            : null);
  }
}
