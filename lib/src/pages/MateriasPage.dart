import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:AP/src/models/Materias.dart';
import 'package:AP/src/providers/servicesMaterias.dart';
import 'package:AP/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AP/utils/env.dart';
import '../../utils/CustomBar.dart';

class MateriasPage extends StatefulWidget with NavigationStates {
  @override
  _MateriasPageState createState() => _MateriasPageState();
}

class _MateriasPageState extends State<MateriasPage> {
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
    sharedPreferences.setString('correctos', '0');
    sharedPreferences.setString('incorrectos', '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            customBar('Materias & Asignaturas'), /*CUSTOM WIDGET APP BAR*/
            Expanded(
              child: FutureBuilder(
                future: MateriasServices().getMaterias(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text('Loading'),
                      ),
                    );
                  } else {
                    return MateriasList(materias: snapshot.data, token: token);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class MateriasList extends StatefulWidget {
  final List<Materias> materias;
  final String token;
  
  const MateriasList({
    this.materias,
    this.token,
    Key key,
  }) : super(key: key);

  @override
  _MateriasListState createState() => _MateriasListState();
}

class _MateriasListState extends State<MateriasList> {
  ScrollController _scrollControllerMaterias = new ScrollController();
  List<Materias> materias;
  String token;
  bool _onNotificationListenerCustom(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollControllerMaterias.position.maxScrollExtent >
          _scrollControllerMaterias.offset &&
          _scrollControllerMaterias.position.maxScrollExtent -
              _scrollControllerMaterias.offset <=
              50) {
        print('End Scroll');
      }
    }
    return true;
  }

  @override
  void initState() {
    materias = widget.materias;
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
    final double containerWidth = MediaQuery.of(context).size.width * 0.5;
    return NotificationListener(
      onNotification: _onNotificationListenerCustom,
      child: ListView.builder(
        controller: _scrollControllerMaterias,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: materias.length,
        padding: EdgeInsets.only(left: 20),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              cargarIdMateriasAndNombreMateria(materias[index].id, materias[index].nombreMateria);
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.PreguntasPageClickEvent);
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
                child: Row(
                  children: [
                    FadeInImage(
                      width: 100,
                      height: 100,
                      placeholder:
                      AssetImage('assets/images/loading_image.gif'),
                      image: NetworkImage(
                          api_rest_uri + api_rest_get_image_materias + materias[index].imagenMateria,
                          headers: {
                            'Authorization': 'Bearer $token',
                          }),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: containerWidth,
                          child: Text(
                            "${materias[index].nombreMateria}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          width: containerWidth,
                          child: Text(
                            "(${materias[index].descripcion})",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
