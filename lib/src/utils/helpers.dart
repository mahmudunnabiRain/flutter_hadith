import 'package:flutter/material.dart';

String toBengaliNumber(String eng) {
  String bengali = '';
  for (int i = 0; i < eng.toString().length; i++) {
    switch (eng[i]) {
      case '1':
        bengali = '$bengali১';
        break;
      case '2':
        bengali = '$bengali২';
        break;
      case '3':
        bengali = '$bengali৩';
        break;
      case '4':
        bengali = '$bengali৪';
        break;
      case '5':
        bengali = '$bengali৫';
        break;
      case '6':
        bengali = '$bengali৬';
        break;
      case '7':
        bengali = '$bengali৭';
        break;
      case '8':
        bengali = '$bengali৮';
        break;
      case '9':
        bengali = '$bengali৯';
        break;
      case '0':
        bengali = '$bengali০';
        break;
      default:
        bengali = bengali + eng[i];
    }
  }
  return bengali;
}

mySnack(String message, BuildContext context, {bool danger = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: const TextStyle(color: Colors.white)),
    showCloseIcon: true,
    closeIconColor: Colors.white,
    backgroundColor: !danger ? Colors.blue : Colors.pink,
  ));
}
