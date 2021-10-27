import 'package:flutter/material.dart';
import 'package:AP/src/models/Respuestas.dart';
import 'package:AP/src/models/Respondidos.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RespuestasList extends StatefulWidget {
  final List<Respuestas> respuestas;
  final String token;
  final int respuestaCorrecta;
  final Respondidos respondidos;

  const RespuestasList({
    this.respuestas,
    this.token,
    this.respuestaCorrecta,
    this.respondidos,
    Key key,
  }) : super(key: key);

  @override
  _RespuestasListState createState() => _RespuestasListState();
}

class _RespuestasListState extends State<RespuestasList> with AutomaticKeepAliveClientMixin {
  ScrollController _scrollControllerMaterias = new ScrollController();
  List<Respuestas> respuestas;
  String token;
  int respuestaCorrecta;
  Respondidos respondidos;

  bool selectedRespuesta;

  Color colorRadio;
  int selectRadio = 0;

  SharedPreferences sharedPreferences;

  int correctos = 0;
  int incorrectos = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    respuestas = widget.respuestas;
    token = widget.token;
    respuestaCorrecta = widget.respuestaCorrecta;
    respondidos = widget.respondidos;
    super.initState();

    selectedRespuesta = false;

    correctos = 0;
    incorrectos = 0;

    colorRadio = Colors.grey;

    /*if(respondidos.respuesta == respuestaCorrecta){
      colorRadio = Colors.green;
    }else{
      colorRadio = Colors.red;
    }
    selectRadio = respondidos.respuesta;*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  selectValueRadioButton(valueSelected, respuestaCorrecta){


        if(selectedRespuesta == false){
          selectedRespuesta = true;
          if(valueSelected == respuestaCorrecta){
            correctos = correctos + 1;
            sharedPreferences.setString('correcto', '${correctos}');
            setState(() {
              colorRadio = Colors.green;
              selectRadio = valueSelected;
            });
            Toast.show('Correcto!!', context, duration: 6, gravity: Toast.TOP, backgroundColor: Colors.green);
          }else{
            incorrectos = incorrectos + 1;
            sharedPreferences.setString('incorrecto', '${incorrectos}');
            setState(() {
              colorRadio = Colors.redAccent;
              selectRadio = valueSelected;
            });
            Toast.show('Incorrecto!!', context, duration: 6, gravity: Toast.TOP, backgroundColor: Colors.redAccent);
          }

        }else{
          Toast.show('Esta pregunta ya fue respondida', context, duration: 6, gravity: Toast.TOP, backgroundColor: Colors.redAccent);
        }
        /*if(valueSelected == respuestaCorrecta){
          colorRadio = Colors.green;
        }else{
          colorRadio = Colors.red;
        }
        selectRadio = valueSelected;*/
  }

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width * 1.0;
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: respuestas.length,
      padding: EdgeInsets.only(left: 20),
      itemBuilder: (BuildContext context, int index) {
        return RadioListTile(
          value: respuestas[index].id,
          groupValue: selectRadio,
          title: Text('${respuestas[index].nroRespuesta}.- ${respuestas[index].descripcionRespuesta}'),
          onChanged: (valueSelected){
            selectValueRadioButton(valueSelected, respuestaCorrecta);
          },
          activeColor: colorRadio,
         toggleable: true,
        );
      },
    );
  }
}