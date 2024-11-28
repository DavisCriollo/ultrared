import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/actividades_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/utils/fechaLocal.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';
import 'package:ultrared/src/widgets/no_data.dart';

class ListaActividadesPendientes extends StatefulWidget {
  const ListaActividadesPendientes({Key? key}) : super(key: key);

  @override
  State<ListaActividadesPendientes> createState() => _ListaActividadesPendientesState();
}

class _ListaActividadesPendientesState extends State<ListaActividadesPendientes> {
  final TextEditingController _textSearchController = TextEditingController();
  @override
  void dispose() {
     _textSearchController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final ctrlHome = context.read<HomeController>();
    final ctrlAct = context.read<ActividadesController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Column(
          children: [
            // Cabecera fija
            CabecerasStandarSinUserApp(
              colorBase: cuaternaryColor,
              size: size,
              onTap: () {
                Navigator.pop(context);
              },
              title: 'Actividades Pendientes',
            ),
               Container(
                 margin: EdgeInsets.symmetric(
                     horizontal: size.iScreen(2.0)),
                 padding: EdgeInsets.symmetric(
                     horizontal: size.iScreen(1.5)),
                     decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
color: Colors.white,
                     ),
                 
                 height: size.iScreen(4.0),
                 child: TextField(
                   controller: _textSearchController,
                   autofocus: true,
                   onChanged: (text) {
                     // providerSearchPreFacturas
                         // .onSearchTextPreFacturaPaginacion(
                         //     text);
                         ctrlAct.search(text);
                       
                   },
                   decoration:  InputDecoration(
                     border: InputBorder.none,
                     hintText: 'Buscar...',
                     suffixIcon:
                     //  Icon(Icons.search),
                     // icon: Icon(Icons.search),
                      GestureDetector(child: Icon(Icons.clear),onTap: (){
                       // providerSearchFacturas
                           // .setInfoBusquedaPropietariosPaginacion([]);
                        
                           ctrlAct.buscaActividades(context);
                           _textSearchController.text='';

                     },),
                   ),
                 ),
               ),
            // Lista desplazable
            Expanded(
              child: Consumer<ActividadesController>(
                builder: (_, valueActiv, __) {

                     if (valueActiv.allItemsFilters.isEmpty) {
                            return const NoData(
                              label: 'Por favor espere ....',
                            );
                            // Text("sin datos");
                          }

                          return 
                          
                          (valueActiv.allItemsFilters.isEmpty)
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              
                                              CircularProgressIndicator(),
                                              Text('Por favor espere ....')
                                            ],
                                          ))
                                        : (valueActiv.allItemsFilters.length > 0)
                                            ?


                   ListView.builder(physics: BouncingScrollPhysics(),
                    itemCount: valueActiv.allItemsFilters.length,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemBuilder: (context, index) {
                      final actividad = valueActiv.allItemsFilters[index];
//==============================================//
  String fechaLocal = convertirFechaLocal(actividad['actaFecReg']);
 //==============================================//
                    

                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: size.iScreen(1.0),
                          vertical: size.iScreen(1.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.iScreen(1.0),
                          vertical: size.iScreen(1.0),
                        ),
                        width: size.iScreen(100),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(size.iScreen(1.0)),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                                width: size.iScreen(100),
                              child: Text('${actividad['actaNombreCliente']} ',
                                  style: GoogleFonts.poppins(
                                    fontSize: size.iScreen(1.7),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )),
                            ),
                                Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('CI: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.iScreen(1.7),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Container(
                                  
                                  child: Text(actividad['actaDocCliente'],
                                      style: GoogleFonts.poppins(
                                        fontSize: size.iScreen(1.8),
                                         fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                      )),
                                ),
                              ],
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Fecha: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.iScreen(1.7),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Container(
                                  
                                  child: Text(fechaLocal,
                                      style: GoogleFonts.poppins(
                                        fontSize: size.iScreen(1.8),
                                         fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        letterSpacing: -0.40,
                                      )),
                                ),
                              ],
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Tipo: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.iScreen(1.7),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Container(
                                  
                                  child: Text(actividad['actaTipo'],
                                      style: GoogleFonts.poppins(
                                        fontSize: size.iScreen(1.8),
                                         fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                      )),
                                ),
                              ],
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('servicio Visita: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.iScreen(1.7),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Container(
                                  
                                  child: Text(actividad['actaServiciosVisita'],
                                      style: GoogleFonts.poppins(
                                        fontSize: size.iScreen(1.8),
                                         fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                      )),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Ciudad: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.iScreen(1.7),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Container(
                                  
                                  child: Text(actividad['actaCiudad'],
                                      style: GoogleFonts.poppins(
                                        fontSize: size.iScreen(1.8),
                                         fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        letterSpacing: -0.40,
                                      )),
                                ),
                              ],
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('estado: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.iScreen(1.7),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                Container(
                                  
                                  child: Text(actividad['actaEstado'],
                                      style: GoogleFonts.poppins(
                                        fontSize: size.iScreen(1.8),
                                         fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                      )),
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text('Estado:',
                            //         style: GoogleFonts.poppins(
                            //           fontSize: size.iScreen(1.7),
                            //           fontWeight: FontWeight.normal,
                            //           color: Colors.black,
                            //         )),
                            //     Container(
                            //       decoration: BoxDecoration(
                            //         color: actividad['ccEstado'] == 'CANCELADO'
                            //             ? Colors.green
                            //             : colorPrimario,
                            //         borderRadius: BorderRadius.circular(8.0),
                            //       ),
                            //       padding: EdgeInsets.symmetric(
                            //           horizontal: size.iScreen(1.0)),
                            //       child: Text('${actividad['ccEstado']}',
                            //           style: GoogleFonts.poppins(
                            //             fontSize: size.iScreen(1.8),
                            //             fontWeight: FontWeight.normal,
                            //             color: Colors.white,
                            //             letterSpacing: -0.40,
                            //           )),
                            //     ),
                            //   ],
                            // ),
                            // Otras filas...
                          ],
                        ),
                      );
                    },
                  ): const NoData(
                              label: 'No existen datos para mostar',
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
