import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:AP/src/providers/servicesPreguntas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:AP/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AP/utils/env.dart';
import '../../utils/CustomBar.dart';
import './PreguntasList.dart';

class PreguntasPage extends StatefulWidget with NavigationStates {
  int idMateria;
  String nombreMateria;
  PreguntasPage({this.idMateria, this.nombreMateria, Key key}) : super(key: key);

  @override
  _PreguntasPageState createState() => _PreguntasPageState();
}

class _PreguntasPageState extends State<PreguntasPage> {
  SharedPreferences sharedPreferences;
  String token = '';

  @override
  void initState() {
    this.configuracionInicial();
    super.initState();
  }

  void configuracionInicial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    sharedPreferences.setString('next_page_url', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            customBar(widget.nombreMateria), /*CUSTOM WIDGET APP BAR*/
            Expanded(
              child: FutureBuilder(
                future: PreguntasServices().getPreguntas(idMateria: widget.idMateria),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text('Cargando...!!'),
                      ),
                    );
                  } else {
                    return PreguntasList(preguntas: snapshot.data, token: token);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.check),
          backgroundColor: Colors.lightGreen,
          onPressed: (){

          }
      )
    );
  }
}