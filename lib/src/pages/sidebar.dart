import 'dart:async';

import 'package:AP/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:AP/src/pages/MenuPage.dart';
import 'package:AP/src/providers/getDataUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:AP/utils/env.dart';
import 'package:AP/src/pages/WelcomePage.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  SharedPreferences sharedPreferences;

  String token = '';

  bool _loaded = false;
  var placeholder = AssetImage('assets/images/man_avatar.png');

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSidebarOpenedStreamController.stream;
    isSideBarOpenedSink = isSidebarOpenedStreamController.sink;

    this.configuracionInicial();
  }

  String userName = 'User';
  String userEmail = 'Email';
  String userImage = 'man_avatar.png';

  void configuracionInicial() async {
    await getDataUser.datosDeUsuario().then((value) {
      userName = value.name;
      userEmail = value.email;
      userImage = value.image;
    });

    sharedPreferences = await SharedPreferences.getInstance();

    token = sharedPreferences.getString('token');

    setState(() {
      _loaded = true;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSideBarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final heightToFullScreen = MediaQuery.of(context).copyWith().size.height;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: heightToFullScreen,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFF262AAA), // sidebar color
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: _loaded
                                ? NetworkImage(
                                    api_rest_uri +
                                        api_rest_get_image_user +
                                        userImage,
                                    headers: {
                                        'Authorization': 'Bearer $token',
                                      })
                                : placeholder,
                            radius: 40,
                          ),
                          title: Text(
                            userName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text(
                            userEmail,
                            style: TextStyle(
                                color: Color(0xFF1BB5FD), fontSize: 11),
                          ),
                        ),
                        Divider(
                          height: 64,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuPage(
                          icon: Icons.home,
                          title: "EMSE",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MateriasPageClickEvent);
                          },
                        ),
                        MenuPage(
                          icon: Icons.exit_to_app,
                          title: "Logout",
                          onTap: () {
                            sharedPreferences.remove('token');
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (BuildContext ctx) => WelcomePage()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0,
                    -0.9), // SI LE PONEMOS POSITIVO BAJARA, Y SI NEGATIVO ESTARA ARRIBA
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
