import 'package:flutter/material.dart';

//import 'package:delivery_app/src/pages/sidebar_layout.dart';
import 'package:AP/src/pages/WelcomePage.dart';
import 'utils/constants_util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, primaryColor: kPrimaryColor),
      home: WelcomePage(),
    );
  }
}
