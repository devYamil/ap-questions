import 'package:AP/src/pages/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:AP/src/includes/background_login_includes.dart';
import 'package:AP/utils/constants_util.dart';

import 'package:AP/src/providers/login_provider.dart';

class BodyLoginInclude extends StatelessWidget {
  const BodyLoginInclude({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextEditingController controladorEmail = new TextEditingController();
    TextEditingController controladorPassword = new TextEditingController();

    final _loginProvider = loginProvider;

    return BackgroundLoginIncludes(
      childComponents: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Iniciar Sesion',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300, fontSize: 30.0),
            ),
            SvgPicture.asset(
              'assets/icons/undraw_mobile_login_ikmv.svg',
              height: size.height * 0.3,
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
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: kPrimaryColor,
                  onPressed: () {
                    final responseLogin = _loginProvider.loginPost(
                        email: controladorEmail.text,
                        password: controladorPassword.text,
                        context: context);

                    responseLogin.then((value) {
                      if (value == true) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SideBarLayout();
                        }));
                      }
                    });
                  },
                  child: Text(
                    'Ingresar',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  'No tienes una cuenta ? ',
                  style: GoogleFonts.poppins(
                    color: kPrimaryColor,
                    fontSize: 12,
                  ),
                )
              ],
            )
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
