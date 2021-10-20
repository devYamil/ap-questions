import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customBar(final String titleCustomBar) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Container(
      margin: EdgeInsets.only(left: 30.0),
      child: Text(titleCustomBar,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: Color(0xFF1E88E5),
        ),
        maxLines: 4,
        softWrap: true,
        overflow: TextOverflow.clip,
      ),),
  );
}