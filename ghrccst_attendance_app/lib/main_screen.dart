import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final studentDetails = Provider.of<StudentProvider>(context);
    final student = studentDetails.student;

    //  bluetoothScanner.startScan();
    //  ScanResult result = bluetoothScanner.getResult();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(student.name),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(student.course),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Semester : ' + student.semester.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('current class :'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'result.device.name.toString()',
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: (() => {
                        studentDetails.markAttendance("DEM")
                        /*         studentDetails.markAttendance(
                            student,
                            student.lectures
                                .first) //create a new currentLecture variable */
                      }),
                  child: Text('Mark attendance'))
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
