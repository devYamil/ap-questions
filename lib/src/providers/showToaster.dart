import 'package:toast/toast.dart';
import 'package:flutter/material.dart';

class ToasterClass{
  showToastMessage(BuildContext context, String msg,
      {int duration, int gravity}) async {
    Toast.show(msg, context, duration: duration, gravity: Toast.TOP, backgroundColor: Colors.red);
  }
}