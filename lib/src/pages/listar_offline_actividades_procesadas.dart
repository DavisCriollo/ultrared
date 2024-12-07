import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

class ListaOffLineActividadesProcesados extends StatefulWidget {
  const ListaOffLineActividadesProcesados({Key? key}) : super(key: key);

  @override
  State<ListaOffLineActividadesProcesados> createState() => _ListaOffLineActividadesProcesadosState();
}

class _ListaOffLineActividadesProcesadosState extends State<ListaOffLineActividadesProcesados> {
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
              title: 'Actividades Procesadas OffLine',
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
                         ctrlAct.searchOffLine(text);
                       
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
                        
                           ctrlAct.fetchActas();
                           _textSearchController.text='';

                     },),
                   ),
                 ),
               ),
            // Lista desplazable
            Expanded(
              child: Consumer<ActividadesController>(
                builder: (_, valueActiv, __) {

                     if (valueActiv.allItemsFiltersOffLine.isEmpty) {
                            return const NoData(
                              label: 'Por favor espere ....',
                            );
                            // Text("sin datos");
                          }

                          return 
                          
                          (valueActiv.allItemsFiltersOffLine.isEmpty)
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              
                                              CircularProgressIndicator(),
                                              Text('Por favor espere ....')
                                            ],
                                          ))
                                        : (valueActiv.allItemsFiltersOffLine.length > 0)
                                            ?


                   ListView.builder(physics: BouncingScrollPhysics(),
                    itemCount: valueActiv.allItemsFiltersOffLine.length,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemBuilder: (context, index) {
                      final actividad = valueActiv.allItemsFiltersOffLine[index];
//==============================================//
  String fechaLocal = convertirFechaLocal(actividad['actaFecReg']);
 //==============================================//
                    

                      return Slidable(
                        startActionPane:  ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              // _usuario!.usuario == ausencia['ausUser']
                              //     ? SlidableAction(
                              //         backgroundColor: Colors.purple,
                              //         foregroundColor: Colors.white,
                              //         icon: Icons.edit,
                              //         // label: 'Editar',
                              //         onPressed: (context) {
                              //          final List<String>_ids=[];
                              //          for (var item in  ausencia['idTurno']) {
                              //           _ids.addAll([item.toString()]);
                              //          }
                              //           provider.resetDropDown();
                              //           provider.resetValuesAusencias();
                              //           provider.buscaListaGuardiasReemplazo(_ids);

                              //           provider.getDataAusencia(ausencia);

                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: ((context) => CreaAusencia(
                              //                         usuario: _usuario,
                              //                         action: 'EDIT',
                              //                       ))));
                              //         },
                              //       )
                              //     : Container(),
                              SlidableAction(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      icon: Icons.rate_review_outlined,
                                      label: 'Revisar',
                                      onPressed: (context) {

                                      },
                                    ),
                                    SlidableAction(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.info_outlined,
                                      label: 'Detalle',
                                      onPressed: (context) {

                                      },
                                    )
                            ],),
                        child: Container(
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
                          
                            ],
                          ),
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
