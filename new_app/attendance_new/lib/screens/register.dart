import 'package:flutter/material.dart';
import 'package:attendance_new/navigation/navigators.dart';
import 'package:attendance_new/navigation/routes.dart';
import 'package:attendance_new/widgets/alert_dialog.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';

class NewStudentScreen extends StatelessWidget {
  late final TextEditingController fnameController = TextEditingController();
  late final TextEditingController lnameController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController courseController = TextEditingController();
  late final TextEditingController rollController = TextEditingController();
  late final TextEditingController semesterController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  late final TextEditingController confirmPasswordController =
      TextEditingController();

  NewStudentScreen({super.key});
  final _form = GlobalKey<FormState>(); //for storing form state.

  @override
  Widget build(BuildContext context) {
    mailValidator(text) {
      if (!(text.contains('@')) && text.isNotEmpty) {
        print(text);
        return "Enter a valid email address!";
      }
      return null;
    }

    passValidator(txt) {
      if (txt == null || txt.isEmpty) {
        return "Please enter a password!";
      }
      if (txt.length < 6) {
        return "Password must have 6 characters";
      }
      if (!txt.contains(RegExp(r'[A-Z]'))) {
        return "Password must contain an uppercase";
      }
      if (!txt.contains(RegExp(r'[0-9]'))) {
        return "Password  must contain a digit";
      }
      if (!txt.contains(RegExp(r'[a-z]'))) {
        return "Password must contain a lowercase letter";
      }
      if (passwordController.text != confirmPasswordController.text) {
        return "Passwords don't match";
      } else {
        return null;
      }
    }

    final dw = MediaQuery.of(context).size.width;
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _form, //assigning key to form

            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('this page is for testing only.'),
                  Row(
                    children: [
                      SizedBox(
                        width: dw * 0.35,
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Name cannot be empty';
                            }
                            if (text.contains(RegExp(r'[0-9]'))) {
                              return "Name cannot contain numbers";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'First Name',
                              hintText: 'Enter your first name',
                              hintStyle: TextStyle(fontSize: 12)),
                          controller: fnameController,
                        ),
                      ),
                      SizedBox(
                        width: dw * 0.35,
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Name cannot be empty';
                            }
                            if (text.contains(RegExp(r'[0-9]'))) {
                              return "Name cannot contain numbers";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Last Name',
                              hintText: 'Enter your last name',
                              hintStyle: TextStyle(fontSize: 12)),
                          controller: lnameController,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    validator: (text) => mailValidator(text),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email',
                        hintText: 'Enter your Raisoni Mail address',
                        hintStyle: TextStyle(fontSize: 12)),
                    controller: emailController,
                  ),
                  TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Roll numer cannot be empty';
                      }
                      if (text.contains(RegExp(r'[a-z]')) ||
                          text.contains(RegExp(r'[A-Z]'))) {
                        return "Roll number cannot contain letters";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Roll No',
                        hintText: 'Enter your class roll number',
                        hintStyle: TextStyle(fontSize: 12)),
                    controller: rollController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Enter course',
                        hintText:
                            'Msc Computer Science is defualt for the beta',
                        hintStyle: TextStyle(fontSize: 12)),
                    controller: courseController,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Semester',
                    ),
                    controller: semesterController,
                  ),
                  TextFormField(
                    validator: (text) => passValidator(text),
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                        hintText: 'Select a password',
                        hintStyle: TextStyle(fontSize: 14)),
                    controller: passwordController,
                  ),
                  TextFormField(
                    validator: (text) => passValidator(text),
                    obscureText: true,
                    obscuringCharacter: '#',
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Confirm Password',
                        hintText: 'confrim your password',
                        hintStyle: TextStyle(fontSize: 14)),
                    controller: confirmPasswordController,
                  ),
                ]),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: showFab
          ? ElevatedButton(
              onPressed: (passwordController.text.trim() ==
                      confirmPasswordController.text.trim())
                  ? () async {
                      final isValid = _form.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      final register = await Provider.of<StudentProvider>(
                              context,
                              listen: false)
                          .addStudent({
                        "firstName": fnameController.text,
                        "lastName": lnameController.text,
                        "course": courseController.text.trim(),
                        "email": emailController.text.trim(),
                        "roll": int.parse(rollController.text.trim()),
                        "userName": emailController.text.split("@")[0],
                        "semester": semesterController.text,
                        "password": passwordController.text
                      });
                      if (register) {
                        () => alertDialog(context, 'Registered Succesfully');
                        // ignore: use_build_context_synchronously
                        push(context, NamedRoute.loginScreen);
                      } else {
                        () => alertDialog(context, 'Failed to register');
                      }
                    }
                  : (() => alertDialog(context, 'Passwords Dont Match')),
              child: const Text('Register Now'))
          : null,
    );
  }
}
