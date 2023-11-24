import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

class BotonBase extends StatelessWidget {
  final String label;
  const BotonBase({
    Key? key,
    required this.size, required this.label,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.wScreen(80),
      height: size.hScreen(5.0),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: tercearyColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: size.iScreen(1.6),
              fontWeight: FontWeight.w500,
              color: Colors.white),
         
        ),
      ),
    );
  }
}