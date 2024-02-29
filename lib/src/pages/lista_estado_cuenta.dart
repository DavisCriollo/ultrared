import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/dataTable/cuentas_por_cobrar_datasource.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';
import 'package:ultrared/src/widgets/no_data.dart';

class DataTableEstadoCuenta extends StatelessWidget {
  const DataTableEstadoCuenta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final Responsive size = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //     iconTheme: const IconThemeData(color: Colors.black),
        //     centerTitle: true, // Centra el título en el AppBar
        //     elevation: 0,
        //     backgroundColor: cuaternaryColor, // Fondo blanco
        //     title: Text('Estado de Cuenta',
        //         style: GoogleFonts.poppins(
        //           fontSize: size.iScreen(2.0),
        //           fontWeight: FontWeight.w700,
        //           color: Colors.black,
        //           letterSpacing: -0.40,
        //         ) // Color del título en negro
        //         ),
        //   ),
    
        body: Container(

 width: size.wScreen(100.0),
                         height: size.hScreen(100.0),

          child: Column(
            children: [
              CabecerasStandarApp(colorBase: cuaternaryColor,size: size,onTap: (){Navigator.pop(context);},title:'Estado de Cuenta' ,),
                // CabecerasApp(size: size, colorBase:Colors.white , title: 'Estado de Cuenta',onTap:(){
                //           Navigator.pop(context);
                //         }),
              Consumer<HomeController>(builder: (_, valueEstadoCuenta, __) {  
    
                   if (valueEstadoCuenta.getErrorEstadoDeCuenta==null) {
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              //***********************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              //*****************************************/
                              const CircularProgressIndicator(),
                            ],
                          );
                        } else  if (valueEstadoCuenta.getListaEstadoDeCuenta.isEmpty) {
                          return const NoData(label: 'No tiene información disponible');
                        }
    
    
                return    
       
                               
                                //*****************************************/
                                Column(
                                  children: [
                                     CabecerasApp(size: size, colorBase:cuaternaryColor , title: 'Estado de Cuenta',onTap:(){
                                Navigator.pop(context);
                              }),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: size.iScreen(0.1),
                                            bottom: size.iScreen(0.0)),
                                        width: size.wScreen(100.0),
                                        child: PaginatedDataTable(
                                          arrowHeadColor: primaryColor,
                                          columns: [
                                             
                                            DataColumn(
                                                label: Text('#',
                                                    style: GoogleFonts.lexendDeca(
                                                        // fontSize: size.iScreen(2.0),
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.grey))),
                                                         DataColumn(
                                                label: Text('Fecha',
                                                    style: GoogleFonts.lexendDeca(
                                                        // fontSize: size.iScreen(2.0),
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.grey))),
                                            DataColumn(
                                                numeric: true,
                                                label: Text('Valor',
                                                    style: GoogleFonts.lexendDeca(
                                                        // fontSize: size.iScreen(2.0),
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.grey))),
                                            DataColumn(
                                                label: Text('Abono',
                                                    style: GoogleFonts.lexendDeca(
                                                        // fontSize: size.iScreen(2.0),
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.grey))),
                                                         DataColumn(
                                                label: Text('Saldo',
                                                    style: GoogleFonts.lexendDeca(
                                                        // fontSize: size.iScreen(2.0),
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.grey))),
                                                         DataColumn(
                                                label: Text('Estado',
                                                    style: GoogleFonts.lexendDeca(
                                                        // fontSize: size.iScreen(2.0),
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.grey))),
                                          ],
                                          source: ListaDeCuentasPorCobrarDS(
                                              valueEstadoCuenta.getListaEstadoDeCuenta, size, context),
                                          rowsPerPage: valueEstadoCuenta.getListaEstadoDeCuenta.length,
                                        )),
                                  ],
                                );
                                //***********************************************/
              },),
            ],
          ),
        ),
      ),
    );
  }
}