import 'package:flutter/material.dart';
import 'package:AP/src/models/Respuestas.dart';
import 'package:AP/src/models/Respondidos.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:AP/utils/env.dart';
import 'package:AP/src/providers/calificarManager.dart';

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
  CalificarManager _calificarManager = new CalificarManager();
  SharedPreferences sharedPreferences;
  List<Respuestas> respuestas;
  String token;
  int respuestaCorrecta;
  Respondidos respondidos;

  bool selectedRespuesta;

  Color colorRadio;
  int selectRadio = 0;

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

    colorRadio = Colors.grey;
  }

  @override
  void dispose() {
    super.dispose();
  }

  selectValueRadioButton(valueSelected, respuestaCorrecta){
        if(selectedRespuesta == false){
          selectedRespuesta = true;
          if(valueSelected == respuestaCorrecta){
            _calificarManager.incrementarCorrectos();
            setState(() {
              colorRadio = Colors.green;
              selectRadio = valueSelected;
            });
            Toast.show('Correcto!!', context, duration: 6, gravity: Toast.TOP, backgroundColor: Colors.green);
          }else{
            _calificarManager.incrementarIncorrectos();
            setState(() {
              colorRadio = Colors.redAccent;
              selectRadio = valueSelected;
            });
            Toast.show('Incorrecto!!', context, duration: 6, gravity: Toast.TOP, backgroundColor: Colors.redAccent);
          }

        }else{
          Toast.show('Esta pregunta ya fue respondida', context, duration: 6, gravity: Toast.TOP, backgroundColor: Colors.redAccent);
        }
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
          title: respuestas[index].descripcionRespuesta == null ? Center(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.all(0),
              child: FadeInImage(
                placeholder:
                AssetImage('assets/images/loading_image.gif'),
                image: NetworkImage(
                    api_rest_uri + api_rest_get_image_respuestas + respuestas[index].imagenRespuestas,
                    headers: {
                      'Authorization': 'Bearer $token',
                    }),
              ),
            ),
          ) : Text('${respuestas[index].nroRespuesta}.- ${respuestas[index].descripcionRespuesta}'),
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