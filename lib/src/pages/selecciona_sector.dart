import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/foto_perfil_page.dart';
import 'package:ultrared/src/pages/password_page.dart';
import 'package:ultrared/src/pages/registro_page.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/utils/letras_mayusculas_minusculas.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';
import 'package:ultrared/src/widgets/modal_permisos.dart';
import 'package:ultrared/src/widgets/no_data.dart';

class SeleccionaSector extends StatefulWidget {
  final String? action;
  const SeleccionaSector({Key? key, required this.action}) : super(key: key);

  @override
  State<SeleccionaSector> createState() => _SeleccionaSectorState();
}

class _SeleccionaSectorState extends State<SeleccionaSector> {




  @override
  Widget build(BuildContext context) {
    final _action = widget.action;
    final Responsive size = Responsive.of(context);
    final _ctrl = context.read<HomeController>();
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: cuaternaryColor,
          // appBar: AppBar(
          //   iconTheme: const IconThemeData(color: Colors.black),
          //   centerTitle: true, // Centra el título en el AppBar
          //   elevation: 0,
          //   backgroundColor: cuaternaryColor, // Fondo blanco
          //   title: Text(_action == 'CREATE' ? 'REGISTRO' : 'EDITAR REGISTRO',
          //       style: GoogleFonts.poppins(
          //         fontSize: size.iScreen(2.0),
          //         fontWeight: FontWeight.w700,
          //         color: Colors.black,
          //         letterSpacing: -0.40,
          //       ) // Color del título en negro
          //       ),
          // ),
          body: Container(
              // alignment: Alignment.center,
              // color: Colors.red,
    
              width: size.wScreen(100.0),
              height: size.hScreen(100.0),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      // key: _ctrl,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Container(
                          //   height: size.hScreen(8),
                          //   width: size.wScreen(100),
                          //   padding:
                          //       EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
                  
                          //   // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                          //   child: Image.asset(
                          //     'assets/imgs/LetrasNegro.png',
                          //     fit: BoxFit.contain, // URL de la imagen
                          //   ),
                          // ),
                          // //***********************************************/
                  
                          // SizedBox(
                          //   height: size.iScreen(3.0),
                          // ),
                          // //*****************************************/
                  
                                
                  
                  
                          Container(
                            // height: size.hScreen(40),
                            width: size.wScreen(100),
                            // color: Colors.green, // Puedes ajustar el color según tus preferencias
                            // Puedes agregar contenido adicional en este contenedor
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: size.hScreen(2.0),
                                // ),
                                // SizedBox(
                                //   width: size.wScreen(80),
                                //   height: size.hScreen(8.0),
                                //   child: Text(
                                //     'Internet por Fibra Óptica',
                                //     textAlign: TextAlign.center,
                                //     style: GoogleFonts.poppins(
                                //         fontSize: size.iScreen(2.5),
                                //         fontWeight: FontWeight.w500,
                                //         color: secondaryColor),
                                //   ),
                                // ),
                                // //***********************************************/
                  
                                  //***********************************************/
                        Container(
                          // color:  Colors.red,
                          child: Column(
                            
                            children: [
                          //      Container(
                          //   height: size.hScreen(9.0),
                          //   width: size.wScreen(100),
                          //   padding:
                          //      EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                  
                          //   // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                          //   child: 
                          //   Image.asset(
                          //     'assets/imgs/letras_UR.png', scale: 1.0,
                          //     fit: BoxFit.contain, // URL de la imagen
                          //   ),
                          // ),
                              // SizedBox(
                              //   width: size.wScreen(80),
                              //   height: size.hScreen(6.0),
                              //   child: Text(
                              //     'Seguridad Móvil',
                              //     textAlign: TextAlign.center,
                              //     style: GoogleFonts.poppins(
                              //         fontSize: size.iScreen(2.5),
                              //         fontWeight: FontWeight.w500,
                              //         color: secondaryColor),
                              //   ),
                              // ),
                             
                            ],
                          ),
                        ),
                  
                  CabecerasApp(size: size, colorBase:cuaternaryColor , title:_action == 'CREATE' ? 'REGISTRO' : 'EDITAR REGISTRO',onTap:(){
                        Navigator.pop(context);
                      }),
                  
                        //***********************************************/
                  
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                //***********************************************/
                                GestureDetector(
                                  onTap: () {
                                    final _ctrl = context.read<HomeController>();
                                    _modalActivaServicioEn(context, size, _ctrl);
                                  },
                                  child: Container(
                                      width: size.wScreen(80.0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.iScreen(2.0),
                                          vertical: size.iScreen(1.0)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Consumer<HomeController>(
                                        builder: (_, valueServicio, __) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Espacio entre el icono y el texto
                                              Container(
                                                // color: Colors.red,
                                                width: size.wScreen(60.0),
                                                child: Text(
                                                  valueServicio
                                                              .getItemLugarServicio !=
                                                          ""
                                                      ? valueServicio
                                                          .getItemLugarServicio!
                                                      : 'ACTIVAR SERVICIO EN:   ',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: size.iScreen(
                                                        2.0), // Ajusta según tus necesidades
                                                    fontWeight: FontWeight.w400,
                                                    color: valueServicio
                                                                .getItemLugarServicio !=
                                                            ""
                                                        ? Colors.black
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined, // Cambia el icono según tus necesidades
                                                color: Colors.grey, // Color del icono
                                              ),
                                            ],
                                          );
                                        },
                                      )),
                                ),
                                // //***********************************************/
                  
                                // SizedBox(
                                //   height: size.iScreen(1.0),
                                // ),
                                // //*****************************************/
                                // //***********************************************/
                                // GestureDetector(
                                //    onTap: () {
                                //                 final _ctrl =
                                //                     context.read<HomeController>();
                                //                 _ctrl.buscaPlanesSinToken();
                                //                 _modalPlan(context, size, _ctrl);
                                //               },
                                //   child: Container(
                                //       width: size.wScreen(80.0),
                                //       padding: EdgeInsets.symmetric(
                                //           horizontal: size.iScreen(2.0),
                                //           vertical: size.iScreen(1.0)),
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10.0),
                                //         border: Border.all(
                                //           color: Colors.grey,
                                //           width: 1.0,
                                //         ),
                                //       ),
                                //       child: Consumer<HomeController>(
                                //         builder: (_, valuegPlan, __) {
                                //           return Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               // Espacio entre el icono y el texto
                                //               Container(
                                //                 // color: Colors.red,
                                //                 width: size.wScreen(60.0),
                                //                 child: Text(
                                //                   valuegPlan.getPlanItem !=""
                                //                       ? valuegPlan.getPlanItem
                                //                       : 'SELECCIONA TU PLAN  ',
                                //                   style: GoogleFonts.poppins(
                                //                     fontSize: size.iScreen(
                                //                         2.0), // Ajusta según tus necesidades
                                //                     fontWeight: FontWeight.w400,
                                //                     color: valuegPlan
                                //                                 .getPlanItem !=
                                //                             ""
                                //                         ? Colors.black
                                //                         : Colors.grey,
                                //                   ),
                                //                 ),
                                //               ),
                                //               Icon(
                                //                 Icons
                                //                     .keyboard_arrow_down_outlined, // Cambia el icono según tus necesidades
                                //                 color: Colors.grey, // Color del icono
                                //               ),
                                //             ],
                                //           );
                                //         },
                                //       )),
                                // ),
                  
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                //***********************************************/
                                GestureDetector(
                                  onTap: () {
                                    final _ctrl = context.read<HomeController>();
                                    _ctrl.buscaCiudades();
                                    _modalCiudad(context, size, _ctrl);
                                  },
                                  child: Container(
                                      width: size.wScreen(80.0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.iScreen(2.0),
                                          vertical: size.iScreen(1.0)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Consumer<HomeController>(
                                        builder: (_, valuegetCiudadItem, __) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Espacio entre el icono y el texto
                                              Container(
                                                // color: Colors.red,
                                                width: size.wScreen(60.0),
                                                child: Text(
                                                  valuegetCiudadItem.getCiudadItem !=
                                                          ""
                                                      ? valuegetCiudadItem
                                                          .getCiudadItem
                                                      : 'SELECCIONA TU CIUDAD  ',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: size.iScreen(
                                                        2.0), // Ajusta según tus necesidades
                                                    fontWeight: FontWeight.w400,
                                                    color: valuegetCiudadItem
                                                                .getCiudadItem !=
                                                            ""
                                                        ? Colors.black
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined, // Cambia el icono según tus necesidades
                                                color: Colors.grey, // Color del icono
                                              ),
                                            ],
                                          );
                                        },
                                      )),
                                ),
                                //***********************************************/
                                Consumer<HomeController>(
                                  builder: (_, valuesSector, __) {
                                    return valuesSector.getCiudadItem != ""
                                        ? GestureDetector(
                                            onTap: () {
                                              _modalSectores(context, size, _ctrl);
                                            },
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: size.iScreen(1.0),
                                                ),
                                                Container(
                                                    width: size.wScreen(80.0),
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.iScreen(2.0),
                                                        vertical: size.iScreen(1.0)),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10.0),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Consumer<HomeController>(
                                                      builder: (_, valueSector, __) {
                                                        return Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            // Espacio entre el icono y el texto
                                                            Container(
                                                              // color: Colors.red,
                                                              width:
                                                                  size.wScreen(60.0),
                                                              child: Text(
                                                                valueSector.getSectorItem !=
                                                                        ""
                                                                    ? valueSector
                                                                        .getSectorItem
                                                                    : 'SELECCIONA TU SECTOR',
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                  fontSize: size.iScreen(
                                                                      2.0), // Ajusta según tus necesidades
                                                                  fontWeight:
                                                                      FontWeight.w400,
                                                                  color: valueSector
                                                                              .getSectorItem !=
                                                                          ""
                                                                      ? Colors.black
                                                                      : Colors.grey,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                // _modalSectores(
                                                                //     context, size, _ctrl);
                                                              },
                                                              child: Icon(
                                                                Icons.keyboard_arrow_down_outlined, // Cambia el icono según tus necesidades
                                                                color: Colors.grey, // Color del icono
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )),
                                              ],
                                            ),
                                          )
                                        : Container();
                                    //*****************************************/
                                  },
                                ),
                  
                                //***********************************************/
                                // //***********************************************/
                  
                                // SizedBox(
                                //   height: size.iScreen(1.0),
                                // ),
                                // //*****************************************/
                                // Container(
                                //   // color: Colors.red,
                                //   width: size.wScreen(80.0),
                                //   padding: EdgeInsets.all(size.wScreen(0.0)),
                                //   child: Center(
                                //     child: Container(
                                //       padding: EdgeInsets.symmetric(
                                //           horizontal: size.hScreen(2.0),
                                //           vertical: size.iScreen(0.0)),
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10.0),
                                //         border: Border.all(
                                //           color: Colors.grey,
                                //           width: 1.0,
                                //         ),
                                //       ),
                                //       child: TextFormField(
                                //         initialValue: widget.action == 'CREATE'
                                //             ? ''
                                //             : _ctrl.getItemReferencia,
                                //         maxLines: 3,
                                //         minLines: 1,
                                //         decoration: const InputDecoration(
                                //           suffixIcon: Icon(
                                //             Icons.message_outlined,
                                //             color: secondaryColor,
                                //           ),
                                //           hintText: 'ESCRIBE UNA REFERENCIA ',
                                //           border: InputBorder.none,
                                //         ),
                                //         onChanged: (text) {
                                //           _ctrl.setItemReferencia(text.trim());
                                //         },
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                //***********************************************/
                                Consumer<HomeController>(
                                  builder: (_, valuePlaca, __) {
                                    return valuePlaca.getItemLugarServicio ==
                                            "TRANSPORTE"
                                        ? Column(
                                            children: [
                                              //*****************************************/
                                              SizedBox(
                                                height: size.iScreen(1.0),
                                              ),
                                              //*****************************************/
                                                  Container(
                                                    
                                                // color: Colors.red,
                                                width: size.wScreen(80.0),
                                                padding:
                                                    EdgeInsets.all(size.wScreen(1.0)),
                                                child: Center(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.hScreen(2.0),
                                                        vertical: size.iScreen(0.0)),
                                                   
                                                    child: Text('INFORMACIÓN DEL VEHÍCULO', style: GoogleFonts.poppins(
                                                    fontSize: size.iScreen(
                                                        1.5), // Ajusta según tus necesidades
                                                    fontWeight: FontWeight.w400,
                                                    color:  Colors.black
                                                       
                                                  ),),
                                                  ),
                                                ),
                                              ),
                                              //*****************************************/
                                              SizedBox(
                                                height: size.iScreen(1.0),
                                              ),
                                              //*****************************************/
                                              Container(
                                                // color: Colors.red,
                                                width: size.wScreen(80.0),
                                                padding:
                                                    EdgeInsets.all(size.wScreen(0.0)),
                                                child: Center(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.hScreen(2.0),
                                                        vertical: size.iScreen(0.0)),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10.0),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: TextFormField(
                                                      initialValue:
                                                          widget.action == 'CREATE'
                                                              ? ''
                                                              : _ctrl.getItemPlaca,
                                                      inputFormatters: [
                                                        UpperCaseText(),
                                                      ],
                                                      decoration:
                                                          const InputDecoration(
                                                        suffixIcon: Icon(
                                                          Icons.message_outlined,
                                                          color: secondaryColor,
                                                        ),
                                                        hintText:
                                                            'ESCRIBE PLACA DEL VEHICULO',
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (text) {
                                                        _ctrl.setItemPlaca(
                                                            text.trim());
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //*****************************************/
                                              SizedBox(
                                                height: size.iScreen(1.0),
                                              ),
                                              //*****************************************/
                                              Container(
                                                // color: Colors.red,
                                                width: size.wScreen(80.0),
                                                padding:
                                                    EdgeInsets.all(size.wScreen(0.0)),
                                                child: Center(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.hScreen(2.0),
                                                        vertical: size.iScreen(0.0)),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10.0),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: TextFormField(
                                                      initialValue:
                                                          widget.action == 'CREATE'
                                                              ? ''
                                                              : _ctrl.getItemMarca,
                                                      inputFormatters: [
                                                        UpperCaseText(),
                                                      ],
                                                      decoration:
                                                          const InputDecoration(
                                                        suffixIcon: Icon(
                                                          Icons.message_outlined,
                                                          color: secondaryColor,
                                                        ),
                                                        hintText:
                                                            'ESCRIBE MARCA DEL VEHICULO',
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (text) {
                                                        _ctrl.setItemMarca(
                                                            text.trim());
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //*****************************************/
                                              SizedBox(
                                                height: size.iScreen(1.0),
                                              ),
                                              //*****************************************/
                                              Container(
                                                // color: Colors.red,
                                                width: size.wScreen(80.0),
                                                padding:
                                                    EdgeInsets.all(size.wScreen(0.0)),
                                                child: Center(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.hScreen(2.0),
                                                        vertical: size.iScreen(0.0)),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10.0),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: TextFormField(
                                                      initialValue:
                                                          widget.action == 'CREATE'
                                                              ? ''
                                                              : _ctrl.getItemModelo,
                                                      inputFormatters: [
                                                        UpperCaseText(),
                                                      ],
                                                      decoration:
                                                          const InputDecoration(
                                                        suffixIcon: Icon(
                                                          Icons.message_outlined,
                                                          color: secondaryColor,
                                                        ),
                                                        hintText:
                                                            'ESCRIBE MODELO DEL VEHICULO',
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (text) {
                                                        _ctrl.setItemModelo(
                                                            text.trim());
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //*****************************************/
                                              SizedBox(
                                                height: size.iScreen(1.0),
                                              ),
                                              //*****************************************/
                                              Container(
                                                // color: Colors.red,
                                                width: size.wScreen(80.0),
                                                padding:
                                                    EdgeInsets.all(size.wScreen(0.0)),
                                                child: Center(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.hScreen(2.0),
                                                        vertical: size.iScreen(0.0)),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10.0),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: TextFormField(
                                                      initialValue:
                                                          widget.action == 'CREATE'
                                                              ? ''
                                                              : _ctrl.getItemColor,
                                                      inputFormatters: [
                                                        UpperCaseText(),
                                                      ],
                                                      decoration:
                                                          const InputDecoration(
                                                        suffixIcon: Icon(
                                                          Icons.message_outlined,
                                                          color: secondaryColor,
                                                        ),
                                                        hintText:
                                                            'ESCRIBE COLOR DEL VEHICULO',
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (text) {
                                                        _ctrl.setItemColor(
                                                            text.trim());
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container();
                                  },
                                ),
                                   //***********************************************/
                  
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                Container(
                                  // color: Colors.red,
                                  width: size.wScreen(80.0),
                                  padding: EdgeInsets.all(size.wScreen(0.0)),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.hScreen(2.0),
                                          vertical: size.iScreen(0.0)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: TextFormField(
                                        initialValue: widget.action == 'CREATE'
                                            ? ''
                                            : _ctrl.getItemReferencia,
                  
                                        maxLines: 3,
                                        minLines: 1,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.mark_unread_chat_alt_outlined,
                                            color: secondaryColor,
                                          ),
                                          hintText: 'ESCRIBE UNA REFERENCIA ',
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (text) {
                                          _ctrl.setItemReferencia(text.trim());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                //***********************************************/
                                Consumer<HomeController>(
                                  builder: (_, valueGPS, __) {
                                    return valueGPS.getItemLugarServicio == "HOGAR"
                                        ? GestureDetector(
                                            onTap: () async {
                                          
                                              // final status =
                                              //     await Permission.location.request();
                                              // if (status ==  PermissionStatus.granted) {
                                              //   //   // print('============== SI TIENE PERMISOS');
                                              //   await _ctrl.getLocation();
                                              //   // if (_ctrl.getGPSPositione) {
                                              //   //   // Navigator.of(context).pushAndRemoveUntil(
                                              //   //   //     MaterialPageRoute(
                                              //   //   //         builder: (context) => HomePage(
                                              //   //   //               // validaTurno: validaTurno,
                                              //   //   //               // tipo: session.rol,
                                              //   //   //               // user: session,
                                              //   //   //               // ubicacionGPS: controllerHome.getCoords,
                                              //   //   //             )),
                                              //   //   //     (Route<dynamic> route) => false);
                                              //   //   // ModalRoute.withName('/');
                                              //   // }
                                              // } else {
                                              //   Navigator.pushNamed(context, 'gps');
                                              // }
                  
                  
                                                                                           // final _ctrlSocket = Provider.of<SocketModel>( context,listen: false);
                   HomeController permissionProvider =
                      Provider.of<HomeController>(context, listen: false);
                        await permissionProvider.checkAndRequestPermissions();
                    bool isGpsEnabled = await permissionProvider.checkGpsStatus();
                    // print('LA INFO ES  ${permissionProvider.hasLocationPermission} ${isGpsEnabled}');
                         
                         if (permissionProvider.hasLocationPermission) {
                            // NotificatiosnService.showSnackBarSuccsses('SIII TIENE PERMISO');
                            if (isGpsEnabled) {
                              //  NotificatiosnService.showSnackBarDanger(' GPS ACTIVADO ');
                                await _ctrl.getLocation();
                  
                                  
                  
                  
                                                             
                             }
                               else {
                              NotificatiosnService.showSnackBarDanger(' Por favor active el GPS');
                            }
                  
                         } else {
                         
                  
                    showPermissionModal(context,size,'Para completar el registro en nuestra aplicación, es necesario otorgar permisos de ubicación.');
                  
                  
                         }
                  
                  
                                            },
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: size.iScreen(1.0),
                                                ),
                                                //***********************************************/
                                                // Container(
                                                //     width: size.wScreen(80.0),
                                                //     padding: EdgeInsets.symmetric(
                                                //         horizontal: size.iScreen(2.0),
                                                //         vertical: size.iScreen(1.0)),
                                                //     decoration: BoxDecoration(
                                                //       borderRadius:
                                                //           BorderRadius.circular(10.0),
                                                //       border: Border.all(
                                                //         color: Colors.grey,
                                                //         width: 1.0,
                                                //       ),
                                                //     ),
                                                //     child: Consumer<HomeController>(
                                                //       builder: (_, valueGPS, __) {
                                                //         return Row(
                                                //           mainAxisAlignment:
                                                //               MainAxisAlignment
                                                //                   .spaceBetween,
                                                //           children: [
                                                //             Container(
                                                //               // color: Colors.red,
                                                //               width:
                                                //                   size.wScreen(60.0),
                                                //               child:
                                                //                   valueGPS.getLocationMessage ==
                                                //                           ""
                                                //                       ? Text(
                                                //                           'UBICACIÓN DE TU HOGAR',
                                                //                           style: GoogleFonts
                                                //                               .poppins(
                                                //                             fontSize:
                                                //                                 size.iScreen(
                                                //                                     2.0), // Ajusta según tus necesidades
                                                //                             fontWeight:
                                                //                                 FontWeight
                                                //                                     .w400,
                                                //                             color: valueGPS.getLocationMessage !=
                                                //                                     ""
                                                //                                 ? Colors
                                                //                                     .black
                                                //                                 : Colors
                                                //                                     .grey,
                                                //                           ),
                                                //                         )
                                                //                       : Text(
                                                //                           '${valueGPS.getLocationMessage}  ',
                                                //                           style: GoogleFonts
                                                //                               .poppins(
                                                //                             fontSize:
                                                //                                 size.iScreen(
                                                //                                     2.0), // Ajusta según tus necesidades
                                                //                             fontWeight:
                                                //                                 FontWeight
                                                //                                     .w400,
                                                //                             color: valueGPS.getLocationMessage !=
                                                //                                     ""
                                                //                                 ? Colors
                                                //                                     .black
                                                //                                 : Colors
                                                //                                     .grey,
                                                //                           ),
                                                //                         ),
                                                //             ),
                                                //             Icon(
                                                //               Icons.explore_outlined, // Cambia el icono según tus necesidades
                                                //               color: valueGPS
                                                //                           .getLocationMessage ==
                                                //                       ""
                                                //                   ? Colors.grey
                                                //                   : tercearyColor, // Color del icono
                                                //             ),
                                                //           ],
                                                //         );
                                                //       },
                                                //     )),
                  
                                                 Container(
                                                    width: size.wScreen(80.0),
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.iScreen(2.0),
                                                        vertical: size.iScreen(1.0)),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10.0),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Consumer<HomeController>(
                                                      builder: (_, valueGPS, __) {
                                                        return Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            // Espacio entre el icono y el texto
                                                            Container(
                                                              // color: Colors.red,
                                                              width:
                                                                  size.wScreen(60.0),
                                                              child: Text(
                                                                valueGPS.locationMessage.toString()!=
                                                                        ""
                                                                    ?  valueGPS.locationMessage.toString()
                                                                    :  'UBICACIÓN DE TU HOGAR',
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                  fontSize: size.iScreen(
                                                                      2.0), // Ajusta según tus necesidades
                                                                  fontWeight:
                                                                      FontWeight.w400,
                                                                  color: valueGPS.locationMessage.toString() !=
                                                                          ""
                                                                      ? Colors.black
                                                                      : Colors.grey,
                                                                ),
                                                              ),
                                                            ),
                                                            const Icon(
                                                              Icons.explore_outlined, // Cambia el icono según tus necesidades
                                                              color: Colors
                                                                  .grey, // Color del icono
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )),
                                              ],
                                            ),
                                          )
                                        : Container();
                                  },
                                ),
                                //*****************************************/
                  
                                //***********************************************/
                                Consumer<HomeController>(builder: (_, valueSize, __) {
                                  return SizedBox(
                                      height:
                                          valueSize.getItemLugarServicio == "HOGAR"
                                              ? size.iScreen(10.0)
                                              : size.iScreen(2.0));
                                }),
                                //*****************************************/
                  
                                GestureDetector(
                                  onTap:  () {
                                          //  final control=context.read<HomeController>();
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: ((context) => FotosPerfilPage())));
                                          // control.setFotoTipo('fotoperfil');
                  
                  //                                if (_ctrl.getItemLugarServicio == 'HOGAR'){
                  
                  //          if (
                  //         _ctrl.getCiudadItem.isEmpty ||
                  //         _ctrl.getSectorItem .isEmpty ||
                  //         _ctrl.getItemReferencia! .isEmpty||
                  //         _ctrl.getLocationMessage .isEmpty) {
                  //       NotificatiosnService.showSnackBarDanger('Falta agregar  información HOME');
                  //        }
                  //   else {
                  //          NotificatiosnService.showSnackBarDanger('CORRECTO HOME');
                  //       }
                  
                  // }
                  
                                          _next(context, _ctrl,_action!);
                                        },
                                      
                                  child: Container(
                                    width: size.wScreen(40.0),
                                    child: BotonBase(
                                      size: size,
                                      label: 'SIGUIENTE',
                                    ),
                                  ),
                                ),
                  
                                SizedBox(
                                  height: size.hScreen(1.0),
                                ),
                  
                        
                  
                  
                                    // CustomPaint(
                                    //   child: Container(
                                    //     color: Colors.red,
                                    //     width: size.wScreen(50.0),
                                    //     height: 100,
                                    //     child: Text('OLA'),
                                        
                                      
                                        
                                    //       ),
                                    //       painter: _HeaderWavePainter(),
                                    // ),
                                    
                  
                  
                              ],
                            ),
                          ),

                         
                          // Container(
                          //     // color:Colors.red,
                          //       height: size.hScreen(5),
                          //       width: size.wScreen(100),
                          //       padding:EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                          //       margin: EdgeInsets.only(bottom: size.iScreen(1.0)),
                                        
                          //       // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                          //       child: Image.asset(
                          //         'assets/imgs/logoColor.png', scale: 1.0,
                          //         fit: BoxFit.contain, // URL de la imagen
                          //       ),
                          //       ),
                        
                        ],
                      ),
                    ),
                 
                 SizedBox(height: size.iScreen(5.0),),
                 Container(
                            // color:Colors.red,
                              height: size.hScreen(5),
                              width: size.wScreen(100),
                              padding:EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                              margin: EdgeInsets.only(bottom: size.iScreen(1.0)),
                                      
                              // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                              child: Image.asset(
                                'assets/imgs/logoColor.png', scale: 1.0,
                                fit: BoxFit.contain, // URL de la imagen
                              ),
                              ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<String?> _modalPlanes(
      BuildContext context, Responsive size, HomeController controller) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: const Text('Selecciona tu plan')),
        content: Container(
          height: size.hScreen(50.0),
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: controller.getlistaPlanes.length,
            itemBuilder: (BuildContext context, int index) {
              final _plan = controller.getlistaPlanes[index];
              // final List _tiposList =
              //     _listaSexoAnimal[index]['sexNombre'];

              return controller.getlistaPlanes.isNotEmpty
                  ? Wrap(
                      children: controller.getlistaPlanes
                          .map(
                            (e) => ListTile(
                              onTap: () {
// print('ESPECIE: ${especiesList['aliNombre']}');
                                controller.setPlanItem(e);
                                // e['sexNombre']);
// print('RAZA: ${e['nombre']}');
                                // controller.setTipoAlimento(e['sexNombre']);

                                Navigator.pop(context);
                              },
                              // title: Text('${e['sexNombre']}'),
                              title: Text('$e'),
                            ),
                          )
                          .toList(),
                    )
                  : const NoData(label: 'No existen alimentos registrados');
            },
          ),
        ),
      ),
    );
  }

  Future<String?> _modalActivaServicioEn(
      BuildContext context, Responsive size, HomeController controller) {
    final _data = ['HOGAR', 'TRANSPORTE'];

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: const Text('Activar servicio en:')),
        content: Container(
          height: size.hScreen(20.0),
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: _data.length,
            itemBuilder: (BuildContext context, int index) {
              final _lugarServicio = _data[index];
              // final List _tiposList =
              //     _listaSexoAnimal[index]['sexNombre'];

              return ListTile(
                onTap: () {
// print('ESPECIE: ${especiesList['aliNombre']}');
                  controller.setItemLugarServicio(_lugarServicio);
                  // e['sexNombre']);
// print('RAZA: ${e['nombre']}');
                  // controller.setTipoAlimento(e['sexNombre']);

                  Navigator.pop(context);
                },
                // title: Text('${e['sexNombre']}'),
                title: Text('$_lugarServicio'),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<String?> _modalCiudad(
      BuildContext context, Responsive size, HomeController controller) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(child: Text('Selecciona tu Ciudad')),
        content: Container(
            height: size.hScreen(50.0),
            width: double.maxFinite,
            child: Consumer<HomeController>(
              builder: (_, valueCiudades, __) {
                if (valueCiudades.getErrorCiudades == null) {
                  return Center(
                    // child: CircularProgressIndicator(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Cargando Datos...',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.5),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        const CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else if (valueCiudades.getErrorCiudades == false) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                  // Text("Error al cargar los datos");
                } else if (valueCiudades.getListaTodasLasCiudades.isEmpty) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                }

                return ListView.builder(
                  itemCount: controller.getListaTodasLasCiudades.length,
                  itemBuilder: (BuildContext context, int index) {
                    final _ciudad = controller.getListaTodasLasCiudades[index];
                    // final List _tiposList =
                    //     _listaSexoAnimal[index]['sexNombre'];

                    return ListTile(
                      onTap: () {
// print('ESPECIE: ${especiesList['aliNombre']}');
                        controller.setSectorItem('');
                        controller.setCiudadItem(_ciudad);
                        // e['sexNombre']);
// print('RAZA: ${e['nombre']}');
                        // controller.setTipoAlimento(e['sexNombre']);

                        Navigator.pop(context);
                      },
                      // title: Text('${e['sexNombre']}'),
                      title: Text('${_ciudad['ciuNombre']}'),
                    );
                  },
                );
              },
            )),
      ),
    );
  }

  Future<String?> _modalPlan(
      BuildContext context, Responsive size, HomeController controller) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(child: Text('Selecciona tu Plan')),
        content: Container(
            height: size.hScreen(50.0),
            width: double.maxFinite,
            child: Consumer<HomeController>(
              builder: (_, valuePlanes, __) {
                if (valuePlanes.getErrorPlanes == null) {
                  return Center(
                    // child: CircularProgressIndicator(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Cargando Datos...',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.5),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        const CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else if (valuePlanes.getErrorPlanes == false) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                  // Text("Error al cargar los datos");
                } else if (valuePlanes.getListaTodosLosPlanes.isEmpty) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                }

                return ListView.builder(
                  itemCount: controller.getListaTodosLosPlanes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final _plan = controller.getListaTodosLosPlanes[index];
                    // final List _tiposList =
                    //     _listaSexoAnimal[index]['sexNombre'];

                    return ListTile(
                      onTap: () {
// print('ESPECIE: ${especiesList['aliNombre']}');

                        controller.setPlanItem(_plan['planNombre']);
                        // e['sexNombre']);
// print('RAZA: ${e['nombre']}');
                        // controller.setTipoAlimento(e['sexNombre']);

                        Navigator.pop(context);
                      },
                      // title: Text('${e['sexNombre']}'),
                      title: Text('${_plan['planNombre']}'),
                    );
                  },
                );
              },
            )),
      ),
    );
  }

  Future<String?> _modalSectores(
      BuildContext context, Responsive size, HomeController controller) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: const Text('Selecciona tu Sector')),
        content: Container(
          height: size.hScreen(50.0),
          width: double.maxFinite,
          child: controller.getlistaSectores.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.getlistaSectores.length,
                  itemBuilder: (BuildContext context, int index) {
                    final _sector = controller.getlistaSectores[index];
                    // final List _tiposList =
                    //     _listaSexoAnimal[index]['sexNombre'];

                    return ListTile(
                      onTap: () {
// print('ESPECIE: ${especiesList['aliNombre']}');
                        controller.setSectorItem(_sector['nombre']);
                        // e['sexNombre']);
// print('RAZA: ${e['nombre']}');
                        // controller.setTipoAlimento(e['sexNombre']);

                        Navigator.pop(context);
                      },
                      // title: Text('${e['sexNombre']}'),
                      title: Text('${_sector['nombre']}'),
                    );
                  },
                )
              : const NoData(label: 'No hay Datos'),
        ),
      ),
    );
  }

  void _next(BuildContext context, HomeController controller, String _action) {
    if (controller.getItemLugarServicio!.isEmpty) {
      NotificatiosnService.showSnackBarDanger('Seleccione Tipo de Servicio');
    }

    if (controller.getItemLugarServicio == 'HOGAR') {
      if (controller.getCiudadItem.isEmpty ||
          controller.getSectorItem.isEmpty ||
          controller.getItemReferencia!.isEmpty ||
          controller.getLocationMessage.isEmpty) {
        NotificatiosnService.showSnackBarDanger(
            'Falta agregar  información ');
      } else {
     
    // controller.setFotoTipo('fotoperfil');
    // Navigator.push(context,
    //     MaterialPageRoute(builder: ((context) => FotosPerfilPage( action: widget.action))));


 Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                     RegistroPage(action: _action))));



      }

    }
    if (controller.getItemLugarServicio == 'TRANSPORTE') {
      if (controller.getCiudadItem.isNotEmpty &&
          controller.getSectorItem.isNotEmpty &&
          controller.getItemReferencia!.isNotEmpty &&
          controller.getItemPlaca!.isNotEmpty &&
          controller.getItemMarca!.isNotEmpty &&
          controller.getItemModelo!.isNotEmpty &&
          controller.getItemColor!.isNotEmpty) {
    //                     controller.setFotoTipo('fotoperfil');
    // Navigator.push(context,
    //     MaterialPageRoute(builder: ((context) => FotosPerfilPage( action: widget.action))));

     Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                     RegistroPage(action: _action))));
      

      } else {
        NotificatiosnService.showSnackBarDanger(
            'Falta agregar  información ');
      }
    }

    
  }



}

