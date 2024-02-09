//========================COPIA TEXTO=========================//
  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/responsive.dart';

SnackBar sNackCopy(String _info, Responsive size, Color _color) {
    return SnackBar(
      backgroundColor: _color,
      content: Text(_info,
          style: GoogleFonts.poppins(
              fontSize: size.iScreen(2.0), fontWeight: FontWeight.bold
              // color: Colors.white,
              )),
    );
  }
