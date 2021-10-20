import 'package:AP/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "My Account Page",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
