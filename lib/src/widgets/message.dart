import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

class MessageChat extends StatelessWidget {
  final String messaje;
  final String type;
  final String uidUser;
  final String uid;
  // final AnimationController animationController;

  const MessageChat({
    Key? key,
    required this.messaje,
    required this.uid,
    required this.type,
    required this.uidUser,
    //  required this.animationController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Container(
      child: uid == uidUser
          ? _myChat(size, messaje, type)
          : null// _noChat(size, messaje, type),
    );
  }
}

_myChat(Responsive size, String messaje, String type) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      // color:  Colors.red,
      padding: EdgeInsets.all(size.iScreen(0.5)),
      margin: EdgeInsets.only(right: 5, bottom: 5, left: 50),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/imgs/Avatar.png'),
          ),
          Container(
              // color: Colors.red ,
              // width: size.wScreen(60.0),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                horizontal: size.iScreen(1.0),
                vertical: size.iScreen(0.5),
              ),
              decoration: BoxDecoration(
                  color: septinaryColor,
                  // color: Color(0xff4D9EF6),
                  borderRadius: BorderRadius.circular(8)),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        // width: size.wScreen(60.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Pedro Cevallos ',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.w600,
                            color: quinquanaryColor,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                      Container(
                          // constraints: BoxConstraints(maxWidth: size.wScreen(60.0)),
                          // alignment: Alignment.centerLeft,
                          constraints: BoxConstraints(
                              // minHeight: size.wScreen(5.0), // Altura mínima

                              minWidth: size.wScreen(5.0),
                              maxWidth: size.wScreen(60.0) // Ancho máximo
                              ),
                          child: type == 'text'
                              ? _messajeTexto(messaje, size)
                              : type == 'img'
                                  ? _messajeImagen(size)
                                  : type == 'video'
                                      ? _messajeVideo(size)
                                      : _messajeAudio(size)),
                      SizedBox(
                        height: size.wScreen(4.0),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text(
                      '14:32',
                      style: GoogleFonts.poppins(
                        fontSize: size.iScreen(1.2),
                        fontWeight: FontWeight.w500,
                        color: sextinaryColor,
                        // letterSpacing: -0.40,
                      ),
                      // textAlign: TextAlign.right,

                      // overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )),
        ],
      ),
      decoration: BoxDecoration(
          // color: Color(0xff4D9EF6),
          // color: Colors.red,
          borderRadius: BorderRadius.circular(8)),
    ),
  );
}

Container _messajeVideo(Responsive size) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey,
      ),
      width: size.wScreen(
        60.0,
      ),
      height: size.hScreen(
        30.0,
      ));
}

Container _messajeAudio(Responsive size) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey,
      ),
      width: size.wScreen(
        60.0,
      ),
      height: size.iScreen(
        30.0,
      ));
}

Container _messajeImagen(Responsive size) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey,
      ),
      width: size.wScreen(
        60.0,
      ),
      height: size.hScreen(
        30.0,
      ));
}

Text _messajeTexto(String messaje, Responsive size) {
  return Text(
    messaje.toString(),
    style: GoogleFonts.poppins(
      fontSize: size.iScreen(1.5),
      fontWeight: FontWeight.w400,
      color: sextinaryColor,
      // letterSpacing: -0.40,
    ),
    textAlign: TextAlign.left,

    maxLines: 2, // Número máximo de líneas permitidas
    // overflow: TextOverflow.ellipsis,
  );
}

_noChat(Responsive size, String messaje, String type) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      // color:  Colors.red,
      padding: EdgeInsets.all(size.iScreen(0.5)),
      margin: EdgeInsets.only(right: 50, bottom: 5, left: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/imgs/Avatar.png'),
          ),
          Container(
              // color: Colors.red ,
              // width: size.wScreen(60.0),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                horizontal: size.iScreen(1.0),
                vertical: size.iScreen(0.5),
              ),
              decoration: BoxDecoration(
                  color: septinaryColor,
                  // color: Color(0xff4D9EF6),
                  borderRadius: BorderRadius.circular(8)),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        // width: size.wScreen(60.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Pedro Cevallos ',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.w600,
                            color: quinquanaryColor,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                      Container(
                        // constraints: BoxConstraints(maxWidth: size.wScreen(60.0)),
                        // alignment: Alignment.centerLeft,
                        constraints: BoxConstraints(
                            // minHeight: size.wScreen(5.0), // Altura mínima

                            minWidth: size.wScreen(5.0),
                            maxWidth: size.wScreen(60.0) // Ancho máximo
                            ),
                        child: Text(
                          messaje,
                          style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.w400,
                            color: sextinaryColor,
                            // letterSpacing: -0.40,
                          ),
                          textAlign: TextAlign.left,

                          maxLines: 2, // Número máximo de líneas permitidas
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: size.wScreen(3.5),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text(
                      '14:32',
                      style: GoogleFonts.poppins(
                        fontSize: size.iScreen(1.2),
                        fontWeight: FontWeight.w500,
                        color: sextinaryColor,
                        // letterSpacing: -0.40,
                      ),
                      // textAlign: TextAlign.right,

                      // overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )),
        ],
      ),
      decoration: BoxDecoration(
          // color: Color(0xff4D9EF6),
          // color: Colors.red,
          borderRadius: BorderRadius.circular(8)),
    ),
  );
}
