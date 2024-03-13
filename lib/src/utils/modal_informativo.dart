import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

void  modalnformativoOK(BuildContext context, Responsive size,String info ) async {
    showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: const Text("Información"),
      content: Text(info),
      actions: <Widget>[
      
       
            TextButton(
          
          child: Text("Aceptar",style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.6),
                            fontWeight: FontWeight.normal,
                            
                            // letterSpacing: -0.40,
                          ),),
          onPressed: () {
          
        Navigator.of(context).pop();


          },
        ),
      ],
    );
  },
);
  }