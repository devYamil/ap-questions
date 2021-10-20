import 'dart:convert';

import 'package:AP/src/models/Users.dart';
import 'package:AP/utils/env.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class _GetDataUser {
  Future<dynamic> datosDeUsuario() async {
    SharedPreferences sharedPreferences;

    sharedPreferences = await SharedPreferences.getInstance();

    final token = sharedPreferences.getString('token');

    final response =
        await http.get(api_rest_uri + api_rest_get_data_user, headers: {
      'Authorization': 'Bearer $token',
    });

    final body = json.decode(response.body);
    final user = body['user'];

    final userData = Users.formJson(user);

    return userData;
  }
}

final getDataUser = _GetDataUser();
