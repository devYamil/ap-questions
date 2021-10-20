import 'package:flutter/material.dart';
import 'package:AP/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AP/src/models/Preguntas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:AP/src/providers/servicesPreguntas.dart';
import '../respuestas/RespuestasList.dart';
import 'package:AP/utils/env.dart';

class PreguntasList extends StatefulWidget {
  final List<Preguntas> preguntas;
  final String token;
  final int idMateria;

  const PreguntasList({
    this.preguntas,
    this.token,
    this.idMateria,
    Key key,
  }) : super(key: key);

  @override
  _PreguntasListState createState() => _PreguntasListState();
}

class _PreguntasListState extends State<PreguntasList> {
  ScrollController _scrollControllerMaterias = new ScrollController();
  List<Preguntas> preguntas;
  String token;
  int idMateria;
  bool esperarEnUso = false;
  bool _onNotificationListenerCustom(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollControllerMaterias.position.maxScrollExtent >
          _scrollControllerMaterias.offset &&
          _scrollControllerMaterias.position.maxScrollExtent -
              _scrollControllerMaterias.offset <=
              50) {
        if(esperarEnUso == false){
          esperarEnUso = true;
          if(esperarEnUso == true){
            setState(() {
              esperarEnUso = true;
            });
          }
          print('End Scroll');
          PreguntasServices().getPreguntas(idMateria : idMateria)
              .then((value) {
            print('DATOS > ${value}');
            setState(() {
              preguntas.addAll(value);
              esperarEnUso = false;
            });
          });
        }
      }
    }
    return true;
  }

  @override
  void initState() {
    preguntas = widget.preguntas;
    token = widget.token;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollControllerMaterias.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width * 1.0;
    return NotificationListener(
      onNotification: _onNotificationListenerCustom,
      child: Stack(
        children: <Widget>[
          ListView.builder(
            controller: _scrollControllerMaterias,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: preguntas.length,
            padding: EdgeInsets.only(left: 20),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  /*cargarIdMateriasAndNombreMateria(preguntas[index].id);
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.DetailProductPageClickEvent);*/
                },
                child: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      right: 15,
                    ),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 25.0, right: 15.0, top: 15.0, bottom: 15.0),
                          width: containerWidth,
                          child: Text(
                            "${preguntas[index].nroPregunta}.- ${preguntas[index].descripcionPregunta}",
                            style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w500,
                              fontSize: 19.0,
                              color: Color(0xFF455A64),
                            ),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        preguntas[index].imagenPreguntas == null ? Container() : Center(
                          child: Container(
                            color: Colors.red,
                            margin: EdgeInsets.all(5),
                            child: FadeInImage(
                              placeholder:
                              AssetImage('assets/images/loading_image.gif'),
                              image: NetworkImage(
                                  api_rest_uri + api_rest_get_image_preguntas + preguntas[index].imagenPreguntas,
                                  headers: {
                                    'Authorization': 'Bearer $token',
                                  }),
                            ),
                          ),
                        ),
                        RespuestasList(respuestas: preguntas[index].respuestas, token: token, respuestaCorrecta: preguntas[index].respuestaCorrecta, respondidos: preguntas[index].respondidos),
                      ],
                    )),
              );
            },
          ),
          esperarEnUso ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Center(
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  margin: EdgeInsets.all(5),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.8,
                    valueColor : AlwaysStoppedAnimation(Colors.grey),
                  ),
                ),
              ),
            ],
          ) : Container(),
        ],
      )
    );
  }
}