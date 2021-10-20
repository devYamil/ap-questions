import 'package:flutter/material.dart';


class BackgroundIncludes extends StatelessWidget {
  final Widget child; // CREAR UN WIDGET CHILD
  const BackgroundIncludes({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provide us total height and width of our screen
    Size size = MediaQuery.of( context ).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // PRIMERA IMAGEN LADO SUPERIOR IZQUIERDO
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_top.png',
              width: size.width * 0.3,
            ),
          ),
          // SEGUNDA IMAGEN LADO INFERIOR IZQUIERDO
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_bottom.png',
              width: size.width * 0.3,
            ),
          ),
          child,
        ],
      ),
    );
  }
}