import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatelessWidget {

  final IconData icon;
  final String title;
  final Function onTap;

  const MenuPage({Key key, this.icon, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.cyan,
              size: 30,
            ),
            SizedBox(width: 20,),
            Text(
              title,
              style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.white
                      ),
            )
          ],
        ),
      ),
    );
  }
}
