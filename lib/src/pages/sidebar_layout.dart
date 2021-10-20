import 'package:AP/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:AP/src/providers/CheckearEstadoLoginProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:AP/src/pages/sidebar.dart';

class SideBarLayout extends StatefulWidget {
  @override
  _SideBarLayoutState createState() => _SideBarLayoutState();
}

class _SideBarLayoutState extends State<SideBarLayout> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();

    checkLoginStatus();
  }

  checkLoginStatus() async {
    checkarEstadoLoginProvider.estadoLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar()
          ],
        ),
      ),
    );
  }
}
