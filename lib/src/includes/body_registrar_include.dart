import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:AP/src/includes/background_login_includes.dart';
import 'package:AP/utils/constants_util.dart';

import 'package:AP/src/providers/login_provider.dart';
import 'package:AP/src/pages/LoginPage.dart';

import 'package:device_info/device_info.dart';

class BodyRegistrarInclude extends StatefulWidget {
  const BodyRegistrarInclude({
    Key key,
  }) : super(key: key);

  @override
  _BodyRegistrarIncludeState createState() => _BodyRegistrarIncludeState();
}

class _BodyRegistrarIncludeState extends State<BodyRegistrarInclude> {

  String identifier;

  @override
  void initState() {
    super.initState();
    identifier = '0-identifier-1';
    getDeviceDetails();
  }

  Future<String> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      }else{
        identifier = '0-identifier-2';
      }
    } catch(E) {
      identifier = '0-identifier-3';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextEditingController controladorName = new TextEditingController();
    TextEditingController controladorEmail = new TextEditingController();
    TextEditingController controladorPassword = new TextEditingController();

    final _loginProvider = loginProvider;

    return BackgroundLoginIncludes(
      childComponents: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registrate...!',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300, fontSize: 30.0),
            ),
            SvgPicture.asset(
              'assets/icons/undraw_social_girl_-562-b.svg',
              height: size.height * 0.3,
            ),
            RoundedInputField(
              hintText: 'Nombre Completo',
              icon: Icons.email,
              onChanged: (value) {},
              controladorEmail: controladorName,
            ),
            RoundedInputField(
              hintText: 'Correo Electronico',
              icon: Icons.email,
              onChanged: (value) {},
              controladorEmail: controladorEmail,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
              controllerPassword: controladorPassword,
            ),
            Container(
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  color: kPrimaryColor,
                  onPressed: () {
                    final responseRegistrar = _loginProvider.registrarPost(
                        name: controladorName.text,
                        email: controladorEmail.text,
                        password: controladorPassword.text,
                        id_dispositivo : identifier,
                        context: context);
                  },
                  child: Text(
                    'Guardar',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  color: kPrimaryColor,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                  },
                  child: Text(
                    'Iniciar Sesion',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controllerPassword;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.controllerPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContenetorTexto(
      childCustom: TextField(
        controller: controllerPassword,
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffix: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controladorEmail;
  const RoundedInputField(
      {Key key,
        this.hintText,
        this.icon = Icons.email,
        this.onChanged,
        this.controladorEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContenetorTexto(
      childCustom: TextField(
        controller: controladorEmail,
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}

class ContenetorTexto extends StatelessWidget {
  final Widget childCustom;
  const ContenetorTexto({Key key, this.childCustom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: kPrimaryLightColor, borderRadius: BorderRadius.circular(29.0)),
      child: childCustom,
    );
  }
}
