import 'package:AP/src/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class _CheckearEstadoLoginProvider {
  void estadoLogin(BuildContext context) async {
    SharedPreferences sharedPreferences;

    sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString('token') == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
      await showToast(context, "La sesion acaba de expirar",
          duration: 20, gravity: Toast.BOTTOM);
    }
  }

  Future<bool> showToast(BuildContext context, String msg,
      {int duration, int gravity}) async {
    Toast.show(msg, context, duration: duration, gravity: gravity);
    return Future.value(true);
  }
}

final checkarEstadoLoginProvider = _CheckearEstadoLoginProvider();
