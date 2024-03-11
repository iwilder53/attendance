import 'package:flutter/material.dart';

Future<dynamic> push(BuildContext context, String routeName,
        {Object? arguments}) =>
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
// Navigator.of(context).pushNamed(routeName, arguments: arguments);

Future<dynamic> pushReplacement(BuildContext context, String routeName,
        {Object? arguments}) =>
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);

Future<dynamic> pushAndRemoveUntil(BuildContext context, String routeName,
        {Object? arguments}) =>
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false,
        arguments: arguments);

pop(context) => Navigator.of(context).pop(context);

dataPop(context, data) => Navigator.of(context).pop(data);
