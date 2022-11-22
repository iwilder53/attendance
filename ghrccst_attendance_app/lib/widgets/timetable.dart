import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/models/lecture_model.dart';
import 'package:ghrccst_attendance_app/providers/lectures_provider.dart';
import 'package:provider/provider.dart';

class TimeTable extends StatelessWidget {
  const TimeTable({super.key, required this.student});
  final student;
  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;
    final timeTableProvider = Provider.of<LecturesProvider>(context);
    List<Lecture> timeTable = Provider.of<LecturesProvider>(context).presentDay;

    return Column(
      children: [
        const Text('Todays Lectures'),
        const Divider(),
        Container(
          color: Colors.white54,
          height: 4 * (dw * 0.3),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemCount: timeTable.length,
            itemBuilder: ((context, index) => Container(
                  padding: EdgeInsets.all(dw * 0.02),
                  decoration: const BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: GridTile(
                    footer: const Text(
                      'Teacher Name',
                      textAlign: TextAlign.right,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeTable[index].subject,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Divider(),
                        Text(timeTable[index].time,
                            style: const TextStyle(fontSize: 16)),
                        TextButton(
                            style: const ButtonStyle(),
                            onPressed: timeTable[index].marked
                                ? null
                                : (() async {
                                    await timeTableProvider
                                        .markPresentDay(index);
                                  }),
                            child: timeTable[index].marked
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : const Icon(Icons.check)),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
