import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/actividades_controller.dart';
import 'package:ultrared/src/utils/fechaLocal.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';


class DetalleActividad extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        final Responsive size = Responsive.of(context);
      final ctrlAct = context.read<ActividadesController>();
      //==============================================//
  String fechaLocal = convertirFechaLocal(ctrlAct.getInfoActividad['actaFecReg']);
 //==============================================//
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
             CabecerasStandarSinUserApp(
              colorBase: cuaternaryColor,
              size: size,
              onTap: () {
                Navigator.pop(context);
              },
              title: 'Detalle Actividad',
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                left: size.iScreen(1.0),
                right: size.iScreen(1.0),
              ),
                width: size.wScreen(100.0),
                height: size.hScreen(100.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                       //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        Row(
                          children: [
                            Container(
                              // width: size.wScreen(100.0),
                
                              // color: Colors.blue,
                              child: Text('Fecha: ',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Container(
                              // width: size.wScreen(100.0),
                              // color: Colors.red,
                              padding: const EdgeInsets.only(),
                              child: Text('$fechaLocal'
                               ,
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey
                                ),
                              ),
                            ),
                          ],
                        ),
                
                      //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        Row(
                          children: [
                            Container(
                              // width: size.wScreen(100.0),
                
                              // color: Colors.blue,
                              child: Text('Estado: ',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Container(
                              // width: size.wScreen(100.0),
                              // color: Colors.red,
                              padding: const EdgeInsets.only(),
                              child: Text(
                               ctrlAct.getInfoActividad['actaEstado'].isNotEmpty? '${ctrlAct.getInfoActividad['actaEstado']}':'--- --- --- --- ---',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey
                                ),
                              ),
                            ),
                          ],
                        ),
                
                       
           //***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Estado: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaEstado'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaEstado']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Opción: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaOpcion'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaOpcion']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Detalle Estado: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaDetalleEstado'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaDetalleEstado']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Tipo: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaTipo'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaTipo']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Cliente: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaSeEncuentraCliente'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaSeEncuentraCliente']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Servicios Visita: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaServiciosVisita'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaServiciosVisita']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Red Wifi: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaRedWifi'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaRedWifi']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Clave: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaClave'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaClave']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Cliente Regulador: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaClienteRegulador'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaClienteRegulador']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Config Router: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaConfigRouter'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaConfigRouter']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),


//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Cambio Patch: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaCambioPatch'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaCambioPatch']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Correo Nuevo Registro: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['correo_nuevo_registro'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['correo_nuevo_registro']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Acta Empresa: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaEmpresa'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaEmpresa']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
// //***********************************************/
// SizedBox(
//   height: size.iScreen(1.0),
// ),
// //*****************************************/
// Row(
//   children: [
//     Container(
//       child: Text(
//         'Acta Id Plan Internet: ',
//         style: GoogleFonts.lexendDeca(
//           fontSize: size.iScreen(2.0),
//           fontWeight: FontWeight.normal,
//           color: Colors.grey,
//         ),
//       ),
//     ),
//     Container(
//       padding: const EdgeInsets.only(),
//       child: Text(
//         ctrlAct.getInfoActividad['actaIdPlanInternet'].isNotEmpty
//             ? '${ctrlAct.getInfoActividad['actaIdPlanInternet']}'
//             : '--- --- --- --- ---',
//         style: GoogleFonts.lexendDeca(
//           fontSize: size.iScreen(2.0),
//           fontWeight: FontWeight.normal,
//         ),
//       ),
//     ),
//   ],
// ),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
      width: size.wScreen(100.0),
      child: Text(
        'Acta Ciudad: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaCiudad'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaCiudad']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
       width: size.wScreen(100.0),
      child: Text(
        ' Documento Cliente: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaDocCliente'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaDocCliente']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
       width: size.wScreen(100.0),
      child: Text(
        ' Nombre Cliente: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaNombreCliente'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaNombreCliente']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
       width: size.wScreen(100.0),
      child: Text(
        'Acta Dirección Cliente: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaDireccionCliente'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaDireccionCliente']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
       width: size.wScreen(100.0),
      child: Text(
        'Acta Entidad Documento: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaEntDoc'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaEntDoc']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
       width: size.wScreen(100.0),
      child: Text(
        'Acta Entidad Nombre: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaEntNombre'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaEntNombre']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
       width: size.wScreen(100.0),
      child: Text(
        'Documento Vendedor: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaDocVendedor'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaDocVendedor']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
       width: size.wScreen(100.0),
      child: Text(
        'Nombre Vendedor: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['actaNombreVendedor'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['actaNombreVendedor']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Plan Internet: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['planNombreInternet'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['planNombreInternet']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Valor Internet: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['planValorInternet'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['planValorInternet']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Row(
  children: [
    Container(
      child: Text(
        'Megas Internet: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.only(),
      child: Text(
        ctrlAct.getInfoActividad['planMegasInternet'].isNotEmpty
            ? '${ctrlAct.getInfoActividad['planMegasInternet']}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
       width: size.wScreen(100.0),
      child: Text(
        'Teléfono Cliente: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: 
      
      // Text(
      //   ctrlAct.getInfoActividad['actaTelCliente'].isNotEmpty
      //       ? '${ctrlAct.getInfoActividad['actaTelCliente'][0]}'
      //       : '--- --- --- --- ---',
      //   style: GoogleFonts.lexendDeca(
      //     fontSize: size.iScreen(2.0),
      //     fontWeight: FontWeight.normal,
      //   ),
      // ),
       ctrlAct.getInfoActividad['actaTelCliente'].isNotEmpty
   ? Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: 
     
     
      Wrap(children: (ctrlAct.getInfoActividad['actaTelCliente'] as List).map((e) => 
      Text(
        ctrlAct.getInfoActividad['actaTelCliente'].isNotEmpty
            ? '${e}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      
      )).toList(),
      
      ),
    ):Text('--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
       width: size.wScreen(100.0),
      child: Text(
        'Email Cliente: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    ctrlAct.getInfoActividad['actaEmailCliente'].isNotEmpty
   ? Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: 
     
     
      Wrap(children: (ctrlAct.getInfoActividad['actaEmailCliente'] as List).map((e) => 
      Text(
        ctrlAct.getInfoActividad['actaEmailCliente'].isNotEmpty
            ? '${e}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      
      )).toList(),
      
      ),
    ):Text('--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
       width: size.wScreen(100.0),
      child: Text(
        'Sector: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: 
     
      ctrlAct.getInfoActividad['actaSector'].isNotEmpty
   ? Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: 
     
     
      Wrap(children: (ctrlAct.getInfoActividad['actaSector'] as List).map((e) => 
      Text(
        ctrlAct.getInfoActividad['actaSector'].isNotEmpty
            ? '${e}'
            : '--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),
      
      )).toList(),
      
      ),
    ):Text('--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),),
    ),
  ],
),

//***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
Column(
  children: [
    Container(
       width: size.wScreen(100.0),
      child: Text(
        'Fotos: ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ),
    //***********************************************/
SizedBox(
  height: size.iScreen(1.0),
),
//*****************************************/
    Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: 
     
      ctrlAct.getInfoActividad['actaFotos'].isNotEmpty
   ? Container(
       width: size.wScreen(100.0),
      padding: const EdgeInsets.only(),
      child: 
     
     
      Wrap(children: (ctrlAct.getInfoActividad['actaFotos'] as List).map((e) => 
     FadeInImage(
  placeholder: AssetImage('assets/imgs/loader.gif'), // Imagen de carga local
  image: NetworkImage('${e['url']}'), // URL de la imagen
  fit: BoxFit.cover, // Ajusta cómo se muestra la imagen
  placeholderFit: BoxFit.contain, // Ajusta cómo se muestra el placeholder
  imageErrorBuilder: (context, error, stackTrace) {
    return Icon(
      Icons.broken_image,
      size: 50,
      color: Colors.grey,
    ); // Muestra un ícono en caso de error
  },
)

      
      ).toList(),
      
      ),
    ):Text('--- --- --- --- ---',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(2.0),
          fontWeight: FontWeight.normal,
        ),),
    ),
  ],
),
//***********************************************/
SizedBox(
  height: size.iScreen(2.0),
),


                
                    ],
                  ),
                )
                   ),
            ),
          ],
        ),
       ),
    );
  }
}