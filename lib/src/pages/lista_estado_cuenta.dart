import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/dataTable/cuentas_por_cobrar_datasource.dart';
import 'package:ultrared/src/pages/view_img_documentos.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';
import 'package:ultrared/src/widgets/no_data.dart';

class DataTableEstadoCuenta extends StatelessWidget {
  const DataTableEstadoCuenta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);

  //  String formatDate(String dateStr) {
  //     DateTime dateTime = DateTime.parse(dateStr);
  //     String month = DateFormat('MMMM', 'es').format(dateTime); // Obtiene el nombre del mes en español
  //     String year = DateFormat('yyyy').format(dateTime); // Obtiene el año

  //     return '$month - $year'; // Retorna la fecha en el formato "Mes - Año"
  //   }

    return SafeArea(
//       child: Scaffold(

//         body: Container(

//  width: size.wScreen(100.0),
//                          height: size.hScreen(100.0),

//           child: Column(
//             children: [
//               CabecerasStandarApp(colorBase: cuaternaryColor,size: size,onTap: (){Navigator.pop(context);},title:'Estado de Cuenta' ,),
//                 // CabecerasApp(size: size, colorBase:Colors.white , title: 'Estado de Cuenta',onTap:(){
//                 //           Navigator.pop(context);
//                 //         }),
//               Consumer<HomeController>(builder: (_, valueEstadoCuenta, __) {

//                    if (valueEstadoCuenta.getErrorEstadoDeCuenta==null) {
//                           return Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [

//                               Center(
//                                 child: Text(
//                                   'Esperando Datos...',
//                                   style: GoogleFonts.lexendDeca(
//                                       fontSize: size.iScreen(1.5),
//                                       color: Colors.black87,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               //***********************************************/
//                               SizedBox(
//                                 height: size.iScreen(1.0),
//                               ),
//                               //*****************************************/
//                               const CircularProgressIndicator(),
//                             ],
//                           );
//                         } else  if (valueEstadoCuenta.getListaEstadoDeCuenta.isEmpty) {
//                           return const NoData(label: 'No tiene información disponible');
//                         }

//                 return

//                                 //*****************************************/
//                                 Column(
//                                   children: [
//                                                                 //        CabecerasApp(size: size, colorBase:cuaternaryColor , title: 'Estado de Cuenta',onTap:(){
//                                                                 //   Navigator.pop(context);
//                                                                 // }),
//                                     Container(
//                                         margin: EdgeInsets.only(
//                                             top: size.iScreen(0.1),
//                                             bottom: size.iScreen(0.0)),
//                                         width: size.wScreen(100.0),
//                                         child: PaginatedDataTable(
//                                           arrowHeadColor: Colors.red,
//                                           columns: [

//                                             DataColumn(
//                                                 label: Text('#',
//                                                     style: GoogleFonts.lexendDeca(
//                                                         // fontSize: size.iScreen(2.0),
//                                                         fontWeight: FontWeight.normal,
//                                                         color: Colors.grey))),
//                                                          DataColumn(
//                                                 label: Text('Fecha',
//                                                     style: GoogleFonts.lexendDeca(
//                                                         // fontSize: size.iScreen(2.0),
//                                                         fontWeight: FontWeight.normal,
//                                                         color: Colors.grey))),
//                                             DataColumn(
//                                                 numeric: true,
//                                                 label: Text('Valor',
//                                                     style: GoogleFonts.lexendDeca(
//                                                         // fontSize: size.iScreen(2.0),
//                                                         fontWeight: FontWeight.normal,
//                                                         color: Colors.grey))),
//                                             DataColumn(
//                                                 label: Text('Abono',
//                                                     style: GoogleFonts.lexendDeca(
//                                                         // fontSize: size.iScreen(2.0),
//                                                         fontWeight: FontWeight.normal,
//                                                         color: Colors.grey))),
//                                                          DataColumn(
//                                                 label: Text('Saldo',
//                                                     style: GoogleFonts.lexendDeca(
//                                                         // fontSize: size.iScreen(2.0),
//                                                         fontWeight: FontWeight.normal,
//                                                         color: Colors.grey))),
//                                                          DataColumn(
//                                                 label: Text('Estado',
//                                                     style: GoogleFonts.lexendDeca(
//                                                         // fontSize: size.iScreen(2.0),
//                                                         fontWeight: FontWeight.normal,
//                                                         color: Colors.grey))),
//                                           ],
//                                           source: ListaDeCuentasPorCobrarDS(
//                                               valueEstadoCuenta.getListaEstadoDeCuenta, size, context),
//                                           rowsPerPage: valueEstadoCuenta.getListaEstadoDeCuenta.length,
//                                         )),
//                                   ],
//                                 );
//                                 //***********************************************/
//               },),
//             ],
//           ),
//         ),
//       ),

      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Container(
          width: size.wScreen(100.0),
          height: size.hScreen(100.0),
          child: Column(
            children: [
              CabecerasStandarApp(
                colorBase: cuaternaryColor,
                size: size,
                onTap: () {
                  Navigator.pop(context);
                },
                title: 'Estado de Cuenta',
              ),
              Consumer<HomeController>(
                builder: (_, valueEstadoCuenta, __) {
                  if (valueEstadoCuenta.getErrorEstadoDeCuenta == null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            'Esperando Datos...',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.5),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        CircularProgressIndicator(),
                      ],
                    );
                  } else if (valueEstadoCuenta.getListaEstadoDeCuenta.isEmpty) {
                    return NoData(label: 'No tiene información disponible');
                  }

    //               return Expanded(
    //                 child: SingleChildScrollView(
    //                   physics: const BouncingScrollPhysics(),
    //                   child: Wrap(
    //                     children: valueEstadoCuenta.getListaEstadoDeCuenta
    //                         .map((e) {
    //                             DateTime dateTime = DateTime.parse(e['ccFechaFactura']);
    //   String month = DateFormat('MMMM', 'es').format(dateTime); // Obtiene el nombre del mes en español
    //   String year = DateFormat('yyyy').format(dateTime); // Obtiene el año

    //  final fechaCorta=  '$month - $year'; // Retorna la fecha en el formato "Mes - Año"
    //                           return Container(
    //                               margin: EdgeInsets.symmetric(
    //                                   horizontal: size.iScreen(1.0),
    //                                   vertical: size.iScreen(1.0)),
    //                               padding: EdgeInsets.symmetric(
    //                                   horizontal: size.iScreen(1.0),
    //                                   vertical: size.iScreen(1.0)),
    //                               width: size.iScreen(100),
    //                               // height: size.iScreen(20),
    //                               decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                                 borderRadius: BorderRadius.circular(
    //                                     size.iScreen(
    //                                         1.0)), // Define el radio del borde
    //                                 border: Border.all(
    //                                   // Opcional: añade un borde
    //                                   color: Colors
    //                                       .grey.shade300, // Color del borde
    //                                   width: 0.5, // Ancho del borde
    //                                 ),
    //                               ),
    //                               child: Column(
    //                                 children: [
    //                                      Text(fechaCorta,
    //                                          style: GoogleFonts.poppins(
    //                                            fontSize: size.iScreen(1.7),
    //                                            fontWeight: FontWeight.bold,
    //                                            color: Colors.black,
    //                                            // letterSpacing: -0.40,
    //                                          )),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Text('Estado:',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.7),
    //                                             fontWeight: FontWeight.normal,
    //                                             color: Colors.black,
    //                                             // letterSpacing: -0.40,
    //                                           )),
    //                                       Container(
    //                                         decoration: BoxDecoration(
    //                                           color: e['ccEstado'] == 'CANCELADO' ? Colors.green : colorPrimario,
    //                                           borderRadius: BorderRadius.circular(8.0)
    //                                         ),
                                            
    //                                         padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
    //                                         child: Text('${e['ccEstado']}',
    //                                             style: GoogleFonts.poppins(
    //                                               fontSize: size.iScreen(1.8),
    //                                               fontWeight: FontWeight.normal,
    //                                               color: Colors.white,
    //                                               letterSpacing: -0.40,
    //                                             )),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                      Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Text('Fecha de emisión:',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.7),
    //                                             fontWeight: FontWeight.normal,
    //                                             color: Colors.black,
    //                                             // letterSpacing: -0.40,
    //                                           )),
    //                                       Text('${e['ccFechaFactura']}',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.8),
    //                                             fontWeight: FontWeight.w500,
    //                                             color: Colors.black,
    //                                             letterSpacing: -0.40,
    //                                           )),
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Text('Valor:',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.7),
    //                                             fontWeight: FontWeight.normal,
    //                                             color: Colors.black,
    //                                             // letterSpacing: -0.40,
    //                                           )),
    //                                       Text('\$${e['ccValorFactura']}',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.8),
    //                                             fontWeight: FontWeight.w500,
    //                                             color: Colors.black,
    //                                             letterSpacing: -0.40,
    //                                           )),
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Text('Abono:',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.7),
    //                                             fontWeight: FontWeight.normal,
    //                                             color: Colors.black,
    //                                             // letterSpacing: -0.40,
    //                                           )),
    //                                       Text('\$${e['ccAbono']}',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.8),
    //                                             fontWeight: FontWeight.w500,
    //                                             color: Colors.black,
    //                                             letterSpacing: -0.40,
    //                                           )),
    //                                     ],
    //                                   ),
    //                                    Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Text('Factura:',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.7),
    //                                             fontWeight: FontWeight.normal,
    //                                             color: Colors.black,
    //                                             // letterSpacing: -0.40,
    //                                           )),
    //                                       Text('${e['ccFactura']}',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.8),
    //                                             fontWeight: FontWeight.w500,
    //                                             color: Colors.black,
    //                                             letterSpacing: -0.40,
    //                                           )),
    //                                     ],
    //                                   ),
    //                                   MaterialButton(
    //                                     onPressed: () {
                                     
    //                                        Navigator.push(
    //                                         context,
    //                                         MaterialPageRoute(
    //                                             builder: ((context) =>
    //                                                       PreviewPhotoComprobante(infoImage:'${e['ccPagos'][0]['ccComprobante']}' ,))));
    //                                     },
    //                                     child: Container(
                                         
    //                                       decoration: BoxDecoration(
    //                                          color: colorTerciario,
    //                                          borderRadius: BorderRadius.circular(8)
    //                                       ),
    //                                       margin: EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
    //                                       padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.5)),
    //                                       child: Text('Ver Comprobante',
    //                                               style: GoogleFonts.poppins(
    //                                                 fontSize: size.iScreen(1.7),
    //                                                 fontWeight: FontWeight.w500,
    //                                                 color:  Colors.white,
    //                                                 // letterSpacing: -0.40,
    //                                               )),
    //                                     ),
    //                                   )
    //                                 ],
    //                               ),
    //                             );
    //                         })
    //                         .toList(),
    //                   ),
    //                 ),
    //               );


return Expanded(
  child: SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Wrap(
      children: valueEstadoCuenta.getListaEstadoDeCuenta
          .map((e) {
              // Inicializa la localización para el español
              initializeDateFormatting('es');
              DateTime dateTime = DateTime.parse(e['ccFechaFactura']);
              String month = DateFormat('MMMM', 'es').format(dateTime); // Obtiene el nombre del mes en español
              String year = DateFormat('yyyy').format(dateTime); // Obtiene el año

              final fechaCorta = '$month - $year'; // Retorna el mes y el año en el formato "Mes - Año"

              return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.iScreen(1.0),
                    vertical: size.iScreen(1.0)),
                padding: EdgeInsets.symmetric(
                    horizontal: size.iScreen(1.0),
                    vertical: size.iScreen(1.0)),
                width: size.iScreen(100),
                // height: size.iScreen(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      size.iScreen(1.0)), // Define el radio del borde
                  border: Border.all(
                    // Opcional: añade un borde
                    color: Colors
                        .grey.shade300, // Color del borde
                    width: 0.5, // Ancho del borde
                  ),
                ),
                child: Column(
                  children: [
                       Text(fechaCorta,
                           style: GoogleFonts.poppins(
                             fontSize: size.iScreen(1.7),
                             fontWeight: FontWeight.bold,
                             color: Colors.black,
                           )),
                      // Resto del código...
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Text('Estado:',
                                              style: GoogleFonts.poppins(
                                                fontSize: size.iScreen(1.7),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                                // letterSpacing: -0.40,
                                              )),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: e['ccEstado'] == 'CANCELADO' ? Colors.green : colorPrimario,
                                              borderRadius: BorderRadius.circular(8.0)
                                            ),
                                            
                                            padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
                                            child: Text('${e['ccEstado']}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: size.iScreen(1.8),
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                  letterSpacing: -0.40,
                                                )),
                                          ),
                      ],),
                      
                       Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Fecha de emisión:',
                                              style: GoogleFonts.poppins(
                                                fontSize: size.iScreen(1.7),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                                // letterSpacing: -0.40,
                                              )),
                                          Text('${e['ccFechaFactura']}',
                                              style: GoogleFonts.poppins(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                letterSpacing: -0.40,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Valor:',
                                              style: GoogleFonts.poppins(
                                                fontSize: size.iScreen(1.7),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                                // letterSpacing: -0.40,
                                              )),
                                          Text('\$${e['ccValorFactura']}',
                                              style: GoogleFonts.poppins(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                letterSpacing: -0.40,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Abono:',
                                              style: GoogleFonts.poppins(
                                                fontSize: size.iScreen(1.7),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                                // letterSpacing: -0.40,
                                              )),
                                          Text('\$${e['ccAbono']}',
                                              style: GoogleFonts.poppins(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                letterSpacing: -0.40,
                                              )),
                                        ],
                                      ),
                                       Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Factura:',
                                              style: GoogleFonts.poppins(
                                                fontSize: size.iScreen(1.7),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                                // letterSpacing: -0.40,
                                              )),
                                          Text('${e['ccFactura']}',
                                              style: GoogleFonts.poppins(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                letterSpacing: -0.40,
                                              )),
                                        ],
                                      ),
                                       MaterialButton(
                                        onPressed: () {
                                          if (e['ccPagos'].isNotEmpty ) {
                                            Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                          PreviewPhotoComprobante(infoImage:'${e['ccPagos'][0]['ccComprobante']}' ,))));
                                            
                                          } else {
                                           NotificatiosnService.showSnackBarError('No tiene documeto para mostrar');
                                          }
                                           
                                        },
                                        child: Container(
                                         
                                          decoration: BoxDecoration(
                                             color: colorTerciario,
                                             borderRadius: BorderRadius.circular(8)
                                          ),
                                          margin: EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                                          padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.5)),
                                          child: Text('Ver Comprobante',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: size.iScreen(1.7),
                                                    fontWeight: FontWeight.w500,
                                                    color:  Colors.white,
                                                    // letterSpacing: -0.40,
                                                  )),
                                        ),
                                      )
                      //  Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Text('Estado:',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.7),
    //                                             fontWeight: FontWeight.normal,
    //                                             color: Colors.black,
    //                                             // letterSpacing: -0.40,
    //                                           )),
    //                                       Container(
    //                                         decoration: BoxDecoration(
    //                                           color: e['ccEstado'] == 'CANCELADO' ? Colors.green : colorPrimario,
    //                                           borderRadius: BorderRadius.circular(8.0)
    //                                         ),
                                            
    //                                         padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
    //                                         child: Text('${e['ccEstado']}',
    //                                             style: GoogleFonts.poppins(
    //                                               fontSize: size.iScreen(1.8),
    //                                               fontWeight: FontWeight.normal,
    //                                               color: Colors.white,
    //                                               letterSpacing: -0.40,
    //                                             )),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                      Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Text('Fecha de emisión:',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.7),
    //                                             fontWeight: FontWeight.normal,
    //                                             color: Colors.black,
    //                                             // letterSpacing: -0.40,
    //                                           )),
    //                                       Text('${e['ccFechaFactura']}',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.8),
    //                                             fontWeight: FontWeight.w500,
    //                                             color: Colors.black,
    //                                             letterSpacing: -0.40,
    //                                           )),
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Text('Valor:',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.7),
    //                                             fontWeight: FontWeight.normal,
    //                                             color: Colors.black,
    //                                             // letterSpacing: -0.40,
    //                                           )),
    //                                       Text('\$${e['ccValorFactura']}',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.8),
    //                                             fontWeight: FontWeight.w500,
    //                                             color: Colors.black,
    //                                             letterSpacing: -0.40,
    //                                           )),
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Text('Abono:',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.7),
    //                                             fontWeight: FontWeight.normal,
    //                                             color: Colors.black,
    //                                             // letterSpacing: -0.40,
    //                                           )),
    //                                       Text('\$${e['ccAbono']}',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.8),
    //                                             fontWeight: FontWeight.w500,
    //                                             color: Colors.black,
    //                                             letterSpacing: -0.40,
    //                                           )),
    //                                     ],
    //                                   ),
    //                                    Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Text('Factura:',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.7),
    //                                             fontWeight: FontWeight.normal,
    //                                             color: Colors.black,
    //                                             // letterSpacing: -0.40,
    //                                           )),
    //                                       Text('${e['ccFactura']}',
    //                                           style: GoogleFonts.poppins(
    //                                             fontSize: size.iScreen(1.8),
    //                                             fontWeight: FontWeight.w500,
    //                                             color: Colors.black,
    //                                             letterSpacing: -0.40,
    //                                           )),
    //                                     ],
    //                                   ),
    //                                   MaterialButton(
    //                                     onPressed: () {
                                     
    //                                        Navigator.push(
    //                                         context,
    //                                         MaterialPageRoute(
    //                                             builder: ((context) =>
    //                                                       PreviewPhotoComprobante(infoImage:'${e['ccPagos'][0]['ccComprobante']}' ,))));
    //                                     },
    //                                     child: Container(
                                         
    //                                       decoration: BoxDecoration(
    //                                          color: colorTerciario,
    //                                          borderRadius: BorderRadius.circular(8)
    //                                       ),
    //                                       margin: EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
    //                                       padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.5)),
    //                                       child: Text('Ver Comprobante',
    //                                               style: GoogleFonts.poppins(
    //                                                 fontSize: size.iScreen(1.7),
    //                                                 fontWeight: FontWeight.w500,
    //                                                 color:  Colors.white,
    //                                                 // letterSpacing: -0.40,
    //                                               )),
    //                                     ),
    //                                   )
    //                                 ],
    //                               ),
                  ],
                ),
              );
          })
          .toList(),
    ),
  ),
);


                  // ListView.builder(
                  //   itemCount: valueEstadoCuenta.getListaEstadoDeCuenta.length,

                  //   itemBuilder: (BuildContext context, int index) {

                  //     final item=valueEstadoCuenta.getListaEstadoDeCuenta[index];

                  //     return Container(
                  //       width: size.iScreen(30),
                  //       height: size.iScreen(20),
                  //       child: Text('$item'),
                  //     );

                  //  },);
                  // Expanded(
                  //   child: SingleChildScrollView(
                  //     physics: const BouncingScrollPhysics(),
                  //     child: Container(
                  //       margin: EdgeInsets.only(
                  //         top: size.iScreen(0.1),
                  //         bottom: size.iScreen(0.0),
                  //       ),
                  //       width: size.wScreen(100.0),
                  //       child: PaginatedDataTable(
                  //         arrowHeadColor: Colors.red,
                  //         columns: [
                  //           DataColumn(
                  //             label: Text(
                  //               '#',
                  //               style: GoogleFonts.lexendDeca(
                  //                 fontWeight: FontWeight.normal,
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //           ),
                  //           DataColumn(
                  //             label: Text(
                  //               'Fecha',
                  //               style: GoogleFonts.lexendDeca(
                  //                 fontWeight: FontWeight.normal,
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //           ),
                  //           DataColumn(
                  //             numeric: true,
                  //             label: Text(
                  //               'Valor',
                  //               style: GoogleFonts.lexendDeca(
                  //                 fontWeight: FontWeight.normal,
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //           ),
                  //           DataColumn(
                  //             label: Text(
                  //               'Abono',
                  //               style: GoogleFonts.lexendDeca(
                  //                 fontWeight: FontWeight.normal,
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //           ),
                  //           DataColumn(
                  //             label: Text(
                  //               'Saldo',
                  //               style: GoogleFonts.lexendDeca(
                  //                 fontWeight: FontWeight.normal,
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //           ),
                  //           DataColumn(
                  //             label: Text(
                  //               'Estado',
                  //               style: GoogleFonts.lexendDeca(
                  //                 fontWeight: FontWeight.normal,
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //         source: ListaDeCuentasPorCobrarDS(
                  //           valueEstadoCuenta.getListaEstadoDeCuenta,
                  //           size,
                  //           context,
                  //         ),
                  //         rowsPerPage: valueEstadoCuenta.getListaEstadoDeCuenta.length,
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
