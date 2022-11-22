import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/widgets/app_drawer.dart';
import 'package:ghrccst_attendance_app/widgets/timetable.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final studentDetails = Provider.of<StudentProvider>(context);
    final student = studentDetails.student;

    //  bluetoothScanner.startScan();
    //  ScanResult result = bluetoothScanner.getResult();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          //  physics: const NeverScrollableScrollPhysics(),
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*      Container(
              padding: EdgeInsets.all(4.0),
              height: 50,
              width: 50,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: studentDetails.todaysLectures.length),
                  itemCount: studentDetails.todaysLectures.length,
                  itemBuilder: (context, index) {
                    return Text(studentDetails.todaysLectures[index].name);
                  }),
            ), */
            TimeTable(
              student: studentDetails,
            ),
          ],
        ),
      ),
    );
  }
}
