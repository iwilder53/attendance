import 'package:flutter/material.dart';

Future<dynamic> alertDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: Text(message),
          )));
}
