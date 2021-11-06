import 'package:AP/utils/env.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _LoginProvider {
  //Future<List<dynamic>> loginPost({email, password}) async {
  Future<bool> loginPost({email, password, id_dispositivo, BuildContext context}) async {
    final response = await http.post(
      api_rest_uri + api_rest_login_uri,
      body: {
        'email': email,
        'password': password,
        'id_dispositivo': id_dispositivo,
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      final data = body['data'];

      final token = data['token'];

      sharedPreferences.setString('token', token);

      return Future.value(true);
    } else {
      // STATUS CODE 401
      await showToast(context, 'Error al iniciar sesion',
          duration: 10, gravity: Toast.TOP);
      return Future.value(false);
    }
  }

  Future<bool> registrarPost({name, email, password, id_dispositivo, BuildContext context}) async {
    final response = await http.post(
      api_rest_uri + api_rest_register_uri,
      body: {
        'name': name,
        'email': email,
        'password': password,
        'id_dispositivo': id_dispositivo,
      },
    );

    if (response.statusCode == 200) {
      // STATUS CODE 200
      await showToastSuccess(context, 'Se registro con exito, espera la confirmacion a tu whatsapp!!',
          duration: 16, gravity: Toast.TOP);

      return Future.value(true);
    } else {
      // STATUS CODE 401
      await showToast(context, 'Error al registrarse, intenta nuevamente o contactenos',
          duration: 10, gravity: Toast.TOP);
      return Future.value(false);
    }
  }

  Future<bool> showToast(BuildContext context, String msg,
      {int duration, int gravity}) async {
    Toast.show(msg, context, duration: duration, gravity: gravity, backgroundColor: Colors.red);
    return Future.value(true);
  }

  Future<bool> showToastSuccess(BuildContext context, String msg,
      {int duration, int gravity}) async {
    Toast.show(msg, context, duration: duration, gravity: gravity, backgroundColor: Colors.lightGreen);
    return Future.value(true);
  }
}

final loginProvider = new _LoginProvider();
