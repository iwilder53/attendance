import 'package:flutter/material.dart';

Future<dynamic> alertDialog(BuildContext context, String message) {
  double width = MediaQuery.of(context).size.width;
  return showDialog(
      context: context,
      builder: ((context) => Container(
            height: width * 0.2,
            child: AlertDialog(
              icon: Icon(Icons.error_outline),
              title: Text(message),
            ),
          )));
}
