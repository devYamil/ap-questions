import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:AP/utils/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:AP/src/models/Materias.dart';

class MateriasServices {
  String _nextUrl = '';
  Future<List<Materias>> getMaterias({String url_custom = ''}) async {
    SharedPreferences sharedPreferences;
    List<Materias> materias = [];
    sharedPreferences = await SharedPreferences.getInstance();

    final token = sharedPreferences.getString('token');

    if (_nextUrl == '') {
      _nextUrl = api_rest_uri + api_rest_get_materias;
    }

    if (url_custom != '') {
      _nextUrl = url_custom;
    }

    if (_nextUrl != null) {
      final response = await http.get(_nextUrl, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        for (var pro in jsonData['data']) {
          Materias materia = Materias.formJson(pro);
          materias.add(materia);
        }
        _nextUrl = jsonData['next_page_url'];
      } else {
        throw Exception('Failed to load get products');
      }
    }

    return materias;
  }
}
