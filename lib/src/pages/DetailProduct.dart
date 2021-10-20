import 'package:flutter/material.dart';
import 'package:AP/bloc/navigation_bloc/navigation_bloc.dart';

class DetailProduct extends StatefulWidget with NavigationStates {
  int idProducto;
  DetailProduct({this.idProducto, Key key}) : super(key: key);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    print('EST ES EL ID QUE LLEGA : ${widget.idProducto} ');
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalle producto'),
        ),
      ),
    );
  }
}
