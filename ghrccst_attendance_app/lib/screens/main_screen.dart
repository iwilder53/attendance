import 'package:attendance_new/providers/lectures_provider.dart';
import 'package:attendance_new/widgets/app_drawer.dart';
import 'package:attendance_new/widgets/qr_dialog.dart';
import 'package:attendance_new/widgets/scanner.dart';
import 'package:attendance_new/widgets/timetable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';

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

  bool awaiting = false;
  loaderSwitch() {
    awaiting = !awaiting;
    setState(() {});
  }

  String? currentSubjectCode;
  String message = '';
  @override
  Widget build(BuildContext context) {
    final studentDetails = Provider.of<StudentProvider>(context);
    final student = studentDetails.student;

    create(idx) async {
      loaderSwitch();
      try {
        currentSubjectCode =
            await Provider.of<LecturesProvider>(context, listen: false)
                .createAttendance(student.subjects[idx]);
        // ignore: prefer_interpolation_to_compose_strings
        message = '$currentSubjectCode.' + student.subjects[idx];
        print(message);
        loaderSwitch();
      } on Exception catch (e) {
        print(e);
        loaderSwitch();
      }
    }

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
                    children: [
                      const Text(
                        'Lectures For The Day',
                        style: TextStyle(fontSize: 18),
                      ),
                      awaiting
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.all(dw * 0.01),
                                child: SizedBox(
                                  height: dw * 0.1,
                                  width: dw * 0.1,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                          : Container(
                              height: student.subjects.length * (dw * 0.15),
                              child: ListView.builder(
                                  itemCount: student.subjects.length,
                                  itemBuilder: (ctx, idx) => ListTile(
                                        leading: const Icon(Icons.checklist),
                                        title: Text(student.subjects[idx]),
                                        trailing: IconButton(
                                          icon: const Icon(Icons
                                              .arrow_circle_right_outlined),
                                          onPressed: () async => {
                                            await create(idx),
                                            await qrDialog(
                                                context,
                                                // ignore: prefer_interpolation_to_compose_strings
                                                '$currentSubjectCode.' +
                                                    student.subjects[idx],
                                                dw)
                                          },
                                        ),
                                      )),
                            ),
                    ],
                  )
                : Column(
                    //  physics: const NeverScrollableScrollPhysics(),
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TimeTable(
                        student: studentDetails,
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
