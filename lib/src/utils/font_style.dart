import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ultrared/src/utils/responsive.dart';










// import 'package:storePlace/src/utils/colors.dart';

abstract class FontStyle {
  TextStyle textStyle(final Responsive size, final double sizes,
      final FontWeight fontWeight, final Color color) {
    return GoogleFonts.roboto(
      fontSize: size.iScreen(sizes),
      fontWeight: fontWeight,
      color: color,
    );
  }
}
