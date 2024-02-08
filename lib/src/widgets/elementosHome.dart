import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';



class ElementosHome extends StatelessWidget {
  final String image;
  final bool enabled;
  final String title;
  final String label;
  final Function() onTap;
  const ElementosHome({
    Key? key,
    required this.size,
    required this.enabled,
    required this.image,
    required this.title, 
    required this.label, 
    required this.onTap,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
     
      // splashColor: Colors.red,
      child: Container(
        margin: EdgeInsets.all(size.iScreen(1)),
        padding: EdgeInsets.all(size.iScreen(0.0)),
        decoration: BoxDecoration(
            color: (enabled == false) ? const Color(0xFFcdd0cb) : Colors.white,
            borderRadius: BorderRadius.circular(size.iScreen(1.0))),
        width: size.iScreen(16.0),
        height: size.iScreen(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
            color: (enabled == false) ? const Color(0xFFcdd0cb) : Colors.white,
            borderRadius: BorderRadius.circular(size.iScreen(.0))),
                 width: size.iScreen(18.0),
                padding:EdgeInsets.all(size.iScreen(0.0)),
              child: Container(
                 height: size.iScreen(13.5),

                decoration: BoxDecoration( 
                color: septinaryColor,
                  borderRadius: BorderRadius.circular(size.iScreen(1.0))),
                margin: EdgeInsets.all(size.iScreen(1.0)),
                padding: EdgeInsets.all(size.iScreen(1.0)),
                child: Column(
                  children: [
                    Image.asset(
                      image,
                      fit: BoxFit.contain,
                      width: size.iScreen(7.0),
                    ),
                     Text(title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: size.iScreen(1.4),
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          letterSpacing:  -0.20,
                          )),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
              child: Column(
                children: [
                 
                  Text(label,
                  textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: size.iScreen(1.3),
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          letterSpacing:  -0.28,)),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap:onTap,
    );
  }
}
