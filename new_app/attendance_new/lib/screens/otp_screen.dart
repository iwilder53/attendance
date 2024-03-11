import 'package:attendance_new/navigation/arguments.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  OtpScreenArguments args;

  OtpScreen({super.key, required this.args});
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(54.0),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              decoration: const InputDecoration(hintText: 'OTP'),
            ),
            ElevatedButton(
                onPressed: () => print('login unimplemented'),
                child: Column(
                  children: [
                    Text(args.verificationId.toString()),
                    Text(args.resendToken.toString())
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
