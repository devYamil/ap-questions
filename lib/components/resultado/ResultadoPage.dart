import 'package:flutter/material.dart';
import 'package:AP/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/CustomBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:AP/utils/constants_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultadoPage extends StatefulWidget with NavigationStates {
  @override
  _ResultadoPageState createState() => _ResultadoPageState();
}

class _ResultadoPageState extends State<ResultadoPage> {
  SharedPreferences sharedPreferences;

  int correctos = 0;
  int incorrectos = 0;
  int totalPreguntas = 0;
  int puntaje = 2;

  int correctosResultado = 0;
  int totalResultado = 0;

  @override
  void initState() {
    this.configuracionInicial();
    super.initState();
  }

  void configuracionInicial() async {
    sharedPreferences = await SharedPreferences.getInstance();

    correctos = int.parse(sharedPreferences.getString('correctos'));
    incorrectos = int.parse(sharedPreferences.getString('incorrectos'));
    totalPreguntas = int.parse(sharedPreferences.getString('total_preguntas'));
    if(correctos == null){
      correctos = 0;
    }
    if(incorrectos == null){
      incorrectos = 0;
    }

    if(totalPreguntas == null){
      totalPreguntas = 0;
    }

    correctosResultado = correctos * puntaje;
    totalResultado = totalPreguntas * puntaje;

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 25, left: 50),
          child: Column(
            children: [
              customBar('Puntaje'), /*CUSTOM WIDGET APP BAR*/
              Text('Puntaje por pregunta : ${puntaje}', style: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                fontSize: 19.0,
                color: Color(0xFF455A64),
              )),
              Text('Correctas : ${correctos}', style: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                fontSize: 19.0,
                color: Color(0xFF455A64),
              )),
              Text('Incorrectas : ${incorrectos}', style: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                fontSize: 19.0,
                color: Color(0xFF455A64),
              )),
              Text('Total Preguntas : ${totalPreguntas}', style: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                fontSize: 19.0,
                color: Color(0xFF455A64),
              )),
              SizedBox(height: 20.0,),
              Text('Calificacion : ${correctosResultado}/${totalResultado}', style: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                fontSize: 26.0,
                color: Color(0xFF455A64),
              )),
              SizedBox(height: 20.0,),
              ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: kPrimaryColor,
                  onPressed: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.MateriasPageClickEvent);
                  },
                  child: Text(
                    'Volver a dar la prueba',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
