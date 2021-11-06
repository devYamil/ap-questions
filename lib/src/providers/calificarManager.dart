import 'package:shared_preferences/shared_preferences.dart';

class CalificarManager {

  int correctos = 0;
  int incorrectos = 0;


  Future<void> incrementarCorrectos() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    correctos = int.parse(sharedPreferences.getString('correctos'));

    correctos = correctos + 1;
    sharedPreferences.setString('correctos', '${correctos}');
  }


  Future<void> incrementarIncorrectos() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    incorrectos = int.parse(sharedPreferences.getString('incorrectos'));

    incorrectos = incorrectos + 1;
    sharedPreferences.setString('incorrectos', '${incorrectos}');
  }
}