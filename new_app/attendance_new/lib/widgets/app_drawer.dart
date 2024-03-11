import 'package:attendance_new/navigation/navigators.dart';
import 'package:attendance_new/navigation/routes.dart';
import 'package:attendance_new/providers/lectures_provider.dart';
import 'package:attendance_new/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ds = MediaQuery.of(context).size.width;
    final username = Provider.of<StudentProvider>(context).student.fname;
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello $username!'),
            automaticallyImplyLeading: true,
          ),
          const Divider(
            height: 1,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              push(context, NamedRoute.profilePage);
            },
          ),
          const Divider(
            height: 1,
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('Attendance'),
            onTap: () {},
          ),
          const Divider(
            height: 1,
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('Courses'),
            onTap: () {},
          ),
          const Divider(
            height: 1,
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text('TimeTable'),
            onTap: () {
              push(context, NamedRoute.timeTableScreen);
            },
          ),
          const Divider(
            height: 1,
          ),
          ListTile(
            leading: const Icon(Icons.more_horiz),
            title: const Text('Co-curricular'),
            onTap: () {},
          ),
          SizedBox(
            height: ds * 0.1,
          ),
          TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Provider.of<LecturesProvider>(context, listen: false)
                    .presentDay
                    .clear();
                Provider.of<LecturesProvider>(context, listen: false)
                    .notifyListeners();
                // ignore: use_build_context_synchronously
                pushReplacement(context, NamedRoute.loginScreen);
              },
              child: const Text('Sign Out'))
        ],
      ),
    );
  }
}
