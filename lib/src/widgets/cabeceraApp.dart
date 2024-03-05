import 'package:awesome_icons/awesome_icons.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/lista_notificaciones.dart';
import 'package:ultrared/src/pages/selecciona_sector.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

class CabecerasApp extends StatelessWidget {
  final Function() onTap;
  final Color colorBase;
  final String title;
  const CabecerasApp({
    Key? key,
    required this.size,
    required this.colorBase,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorBase,
        height: size.hScreen(20),
        width: size.wScreen(100.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0XFFB12521), // Primer color con 70% de transparencia
                    Color(0xFFF7931E), // Segundo color con 70% de transparencia
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.1,
                    2.0
                  ], // 70% del primer color, 30% del segundo color
                  // spreadMethod: SpreadMethod.pad, // Agregar difuminación
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                ),
              ),
              width: size.wScreen(100.0),
              height: size.hScreen(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: size.iScreen(3.0), top: size.iScreen(2.0)),
                      alignment: Alignment.centerLeft,
                      width: size.wScreen(100.0),
                      // color: Colors.red,
                      child: GestureDetector(
                          onTap: onTap,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ))),
                  Container(
                    padding: EdgeInsets.only(bottom: size.iScreen(1.0)),
                    child: Text(title,
                        style: GoogleFonts.poppins(
                          fontSize: size.iScreen(3.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          letterSpacing: -0.20,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF7931E),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 0.0),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                  ),
                ),
                width: size.wScreen(100.0),
                height: size.hScreen(4),
              ),
            ),
          ],
        )

        // CustomPaint(
        //   painter: RPSCustomPainter(),
        // ),
        );
  }
}

class CabecerasIconApp extends StatelessWidget {
  final Function() onTap;
  final Color colorBase;
  final String title;
  const CabecerasIconApp({
    Key? key,
    required this.size,
    required this.colorBase,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: colorBase,
            height: size.hScreen(25),
            width: size.wScreen(100.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorPrimario, // Color(0XFFB12521), // Primer color con 70% de transparencia
                        colorTerciario, // Color(0xFFF7931E), // Segundo color con 70% de transparencia
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        2.0
                      ], // 70% del primer color, 30% del segundo color
                      // spreadMethod: SpreadMethod.pad, // Agregar difuminación
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  width: size.wScreen(100.0),
                  height: size.hScreen(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              left: size.iScreen(3.0), top: size.iScreen(0.0)),
                          alignment: Alignment.centerLeft,
                          width: size.wScreen(100.0),
                          // color: Colors.red,
                          child: GestureDetector(
                              onTap: onTap,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ))),
                      Container(
                        padding: EdgeInsets.only(bottom: size.iScreen(2.0)),
                        child: Text(title,
                            style: GoogleFonts.poppins(
                              fontSize: size.iScreen(4.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              letterSpacing: -0.20,
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF7931E),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 0.0),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                      ),
                    ),
                    width: size.wScreen(100.0),
                    height: size.hScreen(4),
                  ),
                ),
              ],
            )

            // CustomPaint(
            //   painter: RPSCustomPainter(),
            // ),
            ),
        Positioned(
          bottom: 15.0,
          right: 50,
          left: 50,
          child: Container(
            width: size.wScreen(20.00),
            height: size.wScreen(20.00),
            decoration: new BoxDecoration(
              color: colorBase,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              size: size.iScreen(6.0),
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}

class CabeceraHomeApp extends StatelessWidget {
  final Function() onTap;
  final Color colorBase;
  final String title;
  const CabeceraHomeApp({
    Key? key,
    required this.size,
    required this.colorBase,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    final ctrlHome = context.read<HomeController>();
    return Stack(
      children: [
        Container(
            // color: Colors.red,
            height: size.hScreen(20),
            width: size.wScreen(100.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorPrimario, // Color(0XFFB12521), // Primer color con 70% de transparencia
                        colorTerciario, // Color(0xFFF7931E), // Segundo color con 70% de transparencia
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        2.0
                      ], // 70% del primer color, 30% del segundo color
                      // spreadMethod: SpreadMethod.pad, // Agregar difuminación
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
                  width: size.wScreen(100.0),
                  height: size.hScreen(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              right: size.iScreen(3.0), top: size.iScreen(0.0)),
                          padding: EdgeInsets.only(
                              left: size.iScreen(0.0), top: size.iScreen(0.0)),
                          alignment: Alignment.centerLeft,
                          // width: size.wScreen(100.0),
                          // color: Colors.red,
                          child: GestureDetector(
                              onTap: onTap,
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: size.iScreen(3.0),
                              ))),
                      Container(
                        //  color: Colors.red,
                        width: size.wScreen(70),
                        padding: EdgeInsets.only(bottom: size.iScreen(0.0)),
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: size.iScreen(3.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            letterSpacing: -0.20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF7931E),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 0.0),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                      ),
                    ),
                    width: size.wScreen(100.0),
                    height: size.hScreen(4),
                  ),
                ),
              ],
            )

            // CustomPaint(
            //   painter: RPSCustomPainter(),
            // ),
            ),
        Positioned(
          bottom: 1.0,
          right: 50,
          left: 50,
          child: Consumer<HomeController>(builder: (_, value, __) {
            return Container(
                width: size.wScreen(20.00),
                height: size.wScreen(20.00),
                decoration: new BoxDecoration(
                  color: colorBase,
                  shape: BoxShape.circle,
                ),
                child:
                    // Icon(Icons.person,size: size.iScreen(6.0),color: Colors.grey,),

                    // Badge(
                    //     position: const BadgePosition(
                    //         top: 0.0, start: 0.0),
                    //     badgeContent: Text(
                    //       //  value.getListaNotificaciones.isNotEmpty?  '${value.getListaNotificaciones.length}':'',
                    //       '${value.getListaTodasLasNotificaciones.length}',
                    //       style: GoogleFonts.poppins(
                    //         fontSize: size.iScreen(1.4),
                    //         fontWeight: FontWeight.normal,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     badgeColor: tercearyColor,
                    //     child: Container(
                    //       // margin: EdgeInsets.only(
                    //       //     right: size.iScreen(2.0)),
                    //       child: IconButton(
                    //           onPressed: () {
                    //             context
                    //                 .read<HomeController>()
                    //                 .buscarNotificaciones(context);

                    //             //

                    //             Navigator.of(context).push(
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         const ListaNotificaciones()));
                    //           },
                    //           icon: Icon(
                    //             Icons.notifications,
                    //             size: size.iScreen(5.5),
                    //             color: Colors.black,
                    //           )),
                    //     ),
                    //   )
                    // Container()
                    Container(
                  // width: 20,
                  // color: Colors.red,
                  // margin: EdgeInsets.only(
                  //     right: size.iScreen(2.0)),
                  child: Badge(
                    position: const BadgePosition(top: 45.0, start: 148.0),
                    badgeContent: Text(
                      //  value.getListaNotificaciones.isNotEmpty?  '${value.getListaNotificaciones.length}':'',
                      value.getListaTodasLasNotificaciones.length <= 9
                          ? '${value.getListaTodasLasNotificaciones.length}'
                          : '+9',
                      style: GoogleFonts.poppins(
                        fontSize: size.iScreen(1.4),
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    badgeColor: tercearyColor,
                    child: InkWell(
                      onTap: () {
                        context
                            .read<HomeController>()
                            .buscarNotificaciones(context);

                        //

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ListaNotificaciones()));
                      },
                      child: Icon(
                        Icons.notifications,
                        size: size.iScreen(5.5),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )

                // : Container()

                );
          }),
        )
      ],
    );
  }
}

class CabecerasIconDrawerApp extends StatelessWidget {
  final Function() onTap;
  final Color colorBase;
  final String name;
  final String code;
  const CabecerasIconDrawerApp({
    Key? key,
    required this.size,
    required this.colorBase,
    required this.name,
    required this.onTap,
    required this.code,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: colorBase,
            height: size.hScreen(25),
            width: size.wScreen(100.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorPrimario, // Color(0XFFB12521), // Primer color con 70% de transparencia
                        colorTerciario, // Color(0xFFF7931E), // Segundo color con 70% de transparencia
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        2.0
                      ], // 70% del primer color, 30% del segundo color
                      // spreadMethod: SpreadMethod.pad, // Agregar difuminación
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  width: size.wScreen(100.0),
                  height: size.hScreen(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: size.iScreen(0.0)),
                        child: Text(
                          '${name}',
                          style: GoogleFonts.poppins(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            letterSpacing: -0.20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: size.iScreen(0.0)),
                        child: Text(
                          'ID ${code}',
                          style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.7),
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            letterSpacing: -0.20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                //  Container(
                //   decoration:  BoxDecoration(
                //        color:  Color(0xFFF7931E),

                //          ),

                //    child: Container(
                //     decoration:  BoxDecoration(
                //       color: Colors.white,
                //        border: Border.all(color: Colors.white,width: 0.0),

                //       borderRadius: BorderRadius.only(
                //         topRight: Radius.circular(40),
                //       ),
                //     ),
                //     // width: size.wScreen(100.0),
                //     // height: size.hScreen(4),

                //                  ),
                //  ),
              ],
            )

            // CustomPaint(
            //   painter: RPSCustomPainter(),
            // ),
            ),
        Positioned(
          bottom: 10,
          left: size.iScreen(12),
          child: Stack(
            children: [
              Container(
                width: size.iScreen(9.0),
                height: size.iScreen(9.0),
                child: Container(
                  child: ClipOval(
                    child: Container(
                      // width: size.iScreen(1.0),
                      // height: size.iScreen(5.0),
                      decoration: BoxDecoration(
                        color: colorBase,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                      child: AspectRatio(
                        aspectRatio:
                            1, // Mantén la relación de aspecto cuadrada
                        child: Consumer<HomeController>(
                          builder: (_, value, __) {
                            return Container(
                              width: 2,
                              height: 2,
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                              ),
                              child: value.getUser!['foto'] != null
                                  ? ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${value.getUser!['foto']}', // Reemplaza con la URL de tu imagen
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(
                                          color: colorTerciario,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipOval(
                                      child: Image.asset(
                                        'assets/imgs/no-image.png', // Reemplaza con la ruta de tu imagen en los activos
                                        width: size.iScreen(3),
                                        height: size.iScreen(3),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 20,
            left: size.iScreen(19),
            child: InkWell(
              onTap: () {
                final _ctrl = context.read<HomeController>();
                _ctrl.resetAllValues();

                _ctrl.buscaUsuarioById(context);

                if (_ctrl.getInfoUsuarioById.isNotEmpty) {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SeleccionaSector(
                            action: 'EDIT',
                          )));
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: colorPrimario,
                      borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.all(size.iScreen(1.0)),
                  child: Icon(
                    FontAwesomeIcons.userEdit,
                    color: Colors.white,
                    size: size.iScreen(1.7),
                  )),
            )),
      ],
    );
  }
}

class CabecerasStandarApp extends StatelessWidget {
  final Function() onTap;
  final Color colorBase;
  final String title;
  const CabecerasStandarApp({
    Key? key,
    required this.size,
    required this.colorBase,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.red,
        height: size.hScreen(15),
        width: size.wScreen(100.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0XFFB12521), // Primer color con 70% de transparencia
                    Color(0xFFF7931E), // Segundo color con 70% de transparencia
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.1,
                    2.0
                  ], // 70% del primer color, 30% del segundo color
                  // spreadMethod: SpreadMethod.pad, // Agregar difuminación
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              width: size.wScreen(100.0),
              height: size.hScreen(12),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: size.iScreen(3.0), top: size.iScreen(0.0)),
                      alignment: Alignment.centerLeft,
                      // width: size.wScreen(100.0),
                      // color: Colors.red,
                      child: GestureDetector(
                          onTap: onTap,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ))),
                  Container(
                    width: size.wScreen(80.0),
                    // color: Colors.red,
                    padding: EdgeInsets.only(bottom: size.iScreen(0.0)),
                    child: Text(title,
                        style: GoogleFonts.poppins(
                          fontSize: size.iScreen(2.5),
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          letterSpacing: -0.20,
                        ),
                        textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
          ],
        )

        // CustomPaint(
        //   painter: RPSCustomPainter(),
        // ),
        );
  }
}

class CabeceraChatApp extends StatelessWidget {
  final Function() onTap;
  final Color colorBase;
  final String title;
  final bool submenu;
  const CabeceraChatApp({
    Key? key,
    required this.size,
    required this.colorBase,
    required this.title,
    required this.onTap,
    required this.submenu,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.hScreen(10),
        width: size.wScreen(100.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0XFFB12521), // Primer color con 70% de transparencia
                    Color(0xFFF7931E), // Segundo color con 70% de transparencia
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.1,
                    2.0
                  ], // 70% del primer color, 30% del segundo color
                  // spreadMethod: SpreadMethod.pad, // Agregar difuminación
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              width: size.wScreen(100.0),
              height: size.hScreen(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.iScreen(3.0),
                          vertical: size.iScreen(0.0)),
                      // alignment: Alignment.centerLeft,
                      // width: size.wScreen(100.0),
                      // color: Colors.red,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: size.iScreen(4.0),
                        height: size.iScreen(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2.0),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/imgs/groups.png', // Reemplaza con la ruta de tu imagen en los activos
                            width: size.iScreen(7.5),
                            height: size.iScreen(7.5),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.iScreen(1.0),
                      ),
                      Container(
                        //  color: Colors.red,
                        width: size.iScreen(18),
                        padding: EdgeInsets.only(bottom: size.iScreen(0.0)),
                        child: Text(
                          '${title} ',
                          style: GoogleFonts.poppins(
                            fontSize: size.iScreen(2.5),
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            letterSpacing: -0.20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  submenu == true
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.iScreen(3.0),
                              vertical: size.iScreen(0.0)),
                          // alignment: Alignment.centerLeft,
                          // width: size.wScreen(100.0),
                          // color: Colors.red,
                          child: GestureDetector(
                              onTap: onTap,
                              child: Icon(
                                Icons.more_vert_outlined,
                                color: Colors.white,
                              )))
                      : Container(),
                ],
              ),
            ),
          ],
        )

        // CustomPaint(
        //   painter: RPSCustomPainter(),
        // ),
        );
  }
}
