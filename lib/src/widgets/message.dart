import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

// class MessageChat extends StatelessWidget {
//   final String messaje;
//   final String type;
//   final Map<String, dynamic>sessionUser;
//   final Map<String, dynamic> user;
//   // final AnimationController animationController;

//   const MessageChat({
//     Key? key,
//     required this.messaje,
//     required this.user,
//     required this.type,
//     required this.sessionUser,
//     //  required this.animationController
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
// String fechaString = "${user['msg_FecReg']}";

//   // Convertir la cadena a DateTime
//   DateTime fecha = DateTime.parse(fechaString);

//   // Convertir a la zona horaria local
//   DateTime fechaLocal = fecha.toLocal();

//   // String horaFormateada = "${fechaLocal.hour}:${fechaLocal.minute}:${fechaLocal.second}";
//   String horaFormateada =   "${fechaLocal.hour < 10 ? '0' : ''}${fechaLocal.hour}:${fechaLocal.minute < 10 ? '0' : ''}${fechaLocal.minute}";
//   // Formatear la fecha para mostrar solo la hora

//   // print("Hora local formateada: $horaFormateada");

//     return Container(
//       child: user['person_id'] == sessionUser['id']
//           ? _myChat(size, messaje, type,user,sessionUser,horaFormateada)
//           : _noChat(size, messaje, type,user,sessionUser ,horaFormateada),
//     );
//   }
// }

// _myChat(Responsive size, String messaje, String type,Map<String, dynamic> user,Map<String, dynamic> sesionUser,String _hora) {
//   return
//    Align(
//     alignment: Alignment.centerRight,
//     child: Container(
//       // color:  Colors.red,
//       padding: EdgeInsets.all(size.iScreen(0.5)),
//       margin: EdgeInsets.only(right: 5, bottom: 5, left: 50),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//            Container(
//                         width: size.iScreen(4.0),
//                         height: size.iScreen(4.0),
//                         margin:EdgeInsets.symmetric(horizontal:size.iScreen(0.3)),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.grey, width: 2.0),
//                         ),
//                         child: ClipOval(
//                           child: CachedNetworkImage(
//                             imageUrl:
//                                 '${sesionUser['foto']}', // Reemplaza con la URL de tu imagen
//                             placeholder: (context, url) =>
//                                 const CircularProgressIndicator(),
//                             errorWidget: (context, url, error) =>
//                                 Icon(Icons.error),
//                             fit: BoxFit.cover,
//                           ),
//                         )),
//           Container(
//               // color: Colors.red ,
//               // width: size.wScreen(60.0),
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.iScreen(1.0),
//                 vertical: size.iScreen(0.5),
//               ),
//               decoration: BoxDecoration(
//                   color: septinaryColor,
//                   // color: Color(0xff4D9EF6),
//                   borderRadius: BorderRadius.circular(8)),
//               child: Stack(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         // width: size.wScreen(60.0),
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           '${user['nombres']} ',
//                           textAlign: TextAlign.left,
//                           style: GoogleFonts.poppins(
//                             fontSize: size.iScreen(1.5),
//                             fontWeight: FontWeight.w600,
//                             color: quinquanaryColor,
//                             letterSpacing: -0.40,
//                           ),
//                         ),
//                       ),
//                       Container(
//                           // constraints: BoxConstraints(maxWidth: size.wScreen(60.0)),
//                           // alignment: Alignment.centerLeft,
//                           constraints: BoxConstraints(
//                               // minHeight: size.wScreen(5.0), // Altura mínima

//                               minWidth: size.wScreen(5.0),
//                               maxWidth: size.wScreen(60.0) // Ancho máximo
//                               ),
//                           child: type == 'text'
//                               ? _messajeTexto(messaje, size)
//                               : type == 'img'
//                                   ? _messajeImagen(size)
//                                   : type == 'video'
//                                       ? _messajeVideo(size)
//                                       : _messajeAudio(size)),
//                       SizedBox(
//                         height: size.wScreen(4.0),
//                       )
//                     ],
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Text(
//                       '$_hora',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.iScreen(1.2),
//                         fontWeight: FontWeight.w500,
//                         color: sextinaryColor,
//                         // letterSpacing: -0.40,
//                       ),
//                       // textAlign: TextAlign.right,

//                       // overflow: TextOverflow.ellipsis,
//                     ),
//                   )
//                 ],
//               )),
//         ],
//       ),
//       decoration: BoxDecoration(
//           // color: Color(0xff4D9EF6),
//           // color: Colors.red,
//           borderRadius: BorderRadius.circular(8)),
//     ),
//   );

// }

// Container _messajeVideo(Responsive size) {
//   return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         color: Colors.grey,
//       ),
//       width: size.wScreen(
//         60.0,
//       ),
//       height: size.hScreen(
//         30.0,
//       ));
// }

// Container _messajeAudio(Responsive size) {
//   return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         color: Colors.grey,
//       ),
//       width: size.wScreen(
//         60.0,
//       ),
//       height: size.iScreen(
//         30.0,
//       ));
// }

// Container _messajeImagen(Responsive size) {
//   return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         color: Colors.grey,
//       ),
//       width: size.wScreen(
//         60.0,
//       ),
//       height: size.hScreen(
//         30.0,
//       ));
// }

// Text _messajeTexto(String messaje, Responsive size) {
//   return Text(
//     messaje.toString(),
//     style: GoogleFonts.poppins(
//       fontSize: size.iScreen(1.5),
//       fontWeight: FontWeight.w400,
//       color: sextinaryColor,
//       // letterSpacing: -0.40,
//     ),
//     textAlign: TextAlign.left,

//     maxLines: 2, // Número máximo de líneas permitidas
//     // overflow: TextOverflow.ellipsis,
//   );
// }

// _noChat(Responsive size, String messaje, String type,Map<String, dynamic> user,Map<String, dynamic> sesionUser,String _hora) {
//   return Align(
//     alignment: Alignment.centerLeft,
//     child: Container(
//       // color:  Colors.red,
//       padding: EdgeInsets.all(size.iScreen(0.5)),
//       margin: EdgeInsets.only(right: 50, bottom: 5, left: 5),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           CircleAvatar(
//             backgroundColor: Colors.transparent,
//             backgroundImage: AssetImage('assets/imgs/Avatar.png'),
//           ),
//           Container(
//               // color: Colors.red ,
//               // width: size.wScreen(60.0),
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.iScreen(1.0),
//                 vertical: size.iScreen(0.5),
//               ),
//               decoration: BoxDecoration(
//                   color: septinaryColor,
//                   // color: Color(0xff4D9EF6),
//                   borderRadius: BorderRadius.circular(8)),
//               child: Stack(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         // width: size.wScreen(60.0),
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Pedro Cevallos ',
//                           textAlign: TextAlign.left,
//                           style: GoogleFonts.poppins(
//                             fontSize: size.iScreen(1.5),
//                             fontWeight: FontWeight.w600,
//                             color: quinquanaryColor,
//                             letterSpacing: -0.40,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         // constraints: BoxConstraints(maxWidth: size.wScreen(60.0)),
//                         // alignment: Alignment.centerLeft,
//                         constraints: BoxConstraints(
//                             // minHeight: size.wScreen(5.0), // Altura mínima

//                             minWidth: size.wScreen(5.0),
//                             maxWidth: size.wScreen(60.0) // Ancho máximo
//                             ),
//                         child: Text(
//                           messaje,
//                           style: GoogleFonts.poppins(
//                             fontSize: size.iScreen(1.5),
//                             fontWeight: FontWeight.w400,
//                             color: sextinaryColor,
//                             // letterSpacing: -0.40,
//                           ),
//                           textAlign: TextAlign.left,

//                           maxLines: 2, // Número máximo de líneas permitidas
//                           // overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.wScreen(3.5),
//                       )
//                     ],
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Text(
//                       '$_hora',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.iScreen(1.2),
//                         fontWeight: FontWeight.w500,
//                         color: sextinaryColor,
//                         // letterSpacing: -0.40,
//                       ),
//                       // textAlign: TextAlign.right,

//                       // overflow: TextOverflow.ellipsis,
//                     ),
//                   )
//                 ],
//               )),
//         ],
//       ),
//       decoration: BoxDecoration(
//           // color: Color(0xff4D9EF6),
//           // color: Colors.red,
//           borderRadius: BorderRadius.circular(8)),
//     ),
//   );
// }

class MessageChat extends StatelessWidget {
  final Map<String, dynamic> messaje;
  final String type;
  // final Map<String, dynamic>sessionUser;
  final Map<String, dynamic> user;
  // final AnimationController animationController;

  const MessageChat({
    Key? key,
    required this.messaje,
    required this.user,
    required this.type,
    // required this.sessionUser,
    //  required this.animationController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    String fechaString = "${messaje['msg_FecReg']}";

    // Convertir la cadena a DateTime
    DateTime fecha = DateTime.parse(fechaString);

    // Convertir a la zona horaria local
    DateTime fechaLocal = fecha.toLocal();

    // String horaFormateada = "${fechaLocal.hour}:${fechaLocal.minute}:${fechaLocal.second}";
    String horaFormateada =
        "${fechaLocal.hour < 10 ? '0' : ''}${fechaLocal.hour}:${fechaLocal.minute < 10 ? '0' : ''}${fechaLocal.minute}";
    // Formatear la fecha para mostrar solo la hora

    print("Hora local formateada: $horaFormateada");

    // DateFormat.Hm().format(myDate.toLocal())

//     String horaFormateada ='';
//   if (messaje['msg_FecReg'] != null) {

//    horaFormateada =DateFormat.jm().format(DateTime.parse("${messaje['msg_FecReg']}").toLocal());
//   // Resto del código
// } else {
//   // Manejo del caso cuando la fecha es nula
//   horaFormateada='';
// }

    return Container(
      child: user['id'] == messaje['person_id']
          ? _myChat(size, messaje, type, horaFormateada)
          // : Text('data')/
          : _noChat(size, messaje, type, horaFormateada),
    );
  }
}

_myChat(
    Responsive size, Map<String, dynamic> messaje, String type, String _hora) {
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
          //  Container(
          //               width: size.iScreen(4.0),
          //               height: size.iScreen(4.0),
          //               margin:EdgeInsets.symmetric(horizontal:size.iScreen(0.3)),
          //               decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 border: Border.all(color: Colors.grey, width: 2.0),
          //               ),
          //               child: ClipOval(
          //                 child: CachedNetworkImage(
          //                   imageUrl:
          //                       '${messaje['foto']}', // Reemplaza con la URL de tu imagen
          //                   placeholder: (context, url) =>
          //                       const CircularProgressIndicator(),
          //                   errorWidget: (context, url, error) =>
          //                       Icon(Icons.error),
          //                   fit: BoxFit.cover,
          //                 ),
          //               )),

          messaje['foto'].isNotEmpty
              ? Container(
                  width: size.iScreen(4.0),
                  height: size.iScreen(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 2.0),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          '${messaje['foto']}', // Reemplaza con la URL de tu imagen
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ))
              : Container(
                //  decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     border: Border.all(color: Colors.grey.shade500, width: 2.0),
                //   ),
                child: ClipOval(
                    child: Image.asset(
                      'assets/imgs/no-image.png',
                      // color: Colors.grey.shade200, // Reemplaza con la ruta de tu imagen en los activos
                      width: size.iScreen(4.0),
                      height: size.iScreen(4.0),
                      fit: BoxFit.cover,
                    ),
                  ),
              ),

          Container(
              // color: Colors.red ,
              // width: size.wScreen(60.0),
              margin:EdgeInsets.only(left: size.iScreen(0.2)),
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
                          '${messaje['nombres']} ',
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
                              ? _messajeTexto(messaje['message_text'], size)
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
                      '$_hora',
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

_noChat(
    Responsive size, Map<String, dynamic> messaje, String type, String _hora) {
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
          // Container(
          //     width: size.iScreen(4.0),
          //     height: size.iScreen(4.0),
          //     margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.3)),
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(color: Colors.grey, width: 2.0),
          //     ),
          //     child: ClipOval(
          //       child: CachedNetworkImage(
          //         imageUrl:
          //             '${messaje['foto']}', // Reemplaza con la URL de tu imagen
          //         placeholder: (context, url) =>
          //             const CircularProgressIndicator(),
          //         errorWidget: (context, url, error) => Icon(Icons.error),
          //         fit: BoxFit.cover,
          //       ),
          //     )),
          messaje['foto'].isNotEmpty
              ? Container(
                  width: size.iScreen(4.0),
                  height: size.iScreen(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 2.0),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          '${messaje['foto']}', // Reemplaza con la URL de tu imagen
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ))
              : ClipOval(
                  child: Image.asset(
                    'assets/imgs/no-image.png', // Reemplaza con la ruta de tu imagen en los activos
                    width: size.iScreen(4.0),
                    height: size.iScreen(4.0),
                    fit: BoxFit.cover,
                  ),
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
                          '${messaje['nombres']} ',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.w600,
                            color: quinquanaryColor,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                      // Container(
                      //   // constraints: BoxConstraints(maxWidth: size.wScreen(60.0)),
                      //   // alignment: Alignment.centerLeft,
                      //   constraints: BoxConstraints(
                      //       // minHeight: size.wScreen(5.0), // Altura mínima

                      //       minWidth: size.wScreen(5.0),
                      //       maxWidth: size.wScreen(60.0) // Ancho máximo
                      //       ),
                      //   child:messaje['message_text']._messajeTexto(messaje['message_text'], size)
                      //   //  Text('data'),
                      // ),
                      // type == 'text'
                      //     ? messaje['message_text']._messajeTexto(messaje['message_text'], size)
                      //     : type == 'img'
                      //         ? _messajeImagen(size)
                      //         : type == 'video'
                      //             ? _messajeVideo(size)
                      //             : _messajeAudio(size)),
                       Container(
                          // constraints: BoxConstraints(maxWidth: size.wScreen(60.0)),
                          // alignment: Alignment.centerLeft,
                          constraints: BoxConstraints(
                              // minHeight: size.wScreen(5.0), // Altura mínima

                              minWidth: size.wScreen(5.0),
                              maxWidth: size.wScreen(60.0) // Ancho máximo
                              ),
                          child: type == 'text'
                              ? _messajeTexto(messaje['message_text'], size)
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
                      '$_hora',
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
