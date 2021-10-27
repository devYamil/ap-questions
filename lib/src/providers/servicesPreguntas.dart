import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:AP/utils/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:AP/src/models/Preguntas.dart';

class PreguntasServices {
  String _nextUrl = '';
  String pagePreguntas = '1';
  Future<List<Preguntas>> getPreguntas({int idMateria = 0}) async {
    SharedPreferences sharedPreferences;
    List<Preguntas> preguntas = [];
    sharedPreferences = await SharedPreferences.getInstance();

    final token = sharedPreferences.getString('token');
    final nextPageUrl = sharedPreferences.getString('next_page_url');

    if(nextPageUrl == ''){
      _nextUrl = '${api_rest_uri}${api_rest_get_preguntas}${idMateria}?page=${pagePreguntas}';
    }else{
      _nextUrl = '${nextPageUrl}';
    }


    print("IMPRIMIENTO URI : ${_nextUrl}");

    if (_nextUrl != null) {
      final response = await http.get(_nextUrl, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        for (var pro in jsonData['data']) {
          Preguntas pregunta = Preguntas.formJson(pro);
          preguntas.add(pregunta);
        }
        sharedPreferences.setString('next_page_url', jsonData['next_page_url']);
        sharedPreferences.setString('total_preguntas', '${jsonData['total']}');
      } else {
        throw Exception('Failed to load get preguntas');
      }
    }

    return preguntas;
  }
}
