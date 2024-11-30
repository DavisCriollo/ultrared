import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/actividades_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';

import 'package:ultrared/src/pages/listar_actividades_pendientes.dart';
import 'package:ultrared/src/pages/listar_actividades_procesadas.dart';
import 'package:ultrared/src/pages/listar_offline_actividades_pendientes.dart';
import 'package:ultrared/src/pages/listar_offline_actividades_procesadas.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';
import 'package:ultrared/src/widgets/items_menu.dart';


class MenuOffLine extends StatelessWidget {
    final Map<String, dynamic>? user;
  const MenuOffLine({Key? key, this.user}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    
      final Responsive size = Responsive.of(context);
   final ctrlHome=context.read<HomeController>();
    final ctrlAct=context.read<ActividadesController>();
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: size.wScreen(100.0),
          height: size.hScreen(100.0),
          // color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CabecerasStandarSinUserApp(
                colorBase: cuaternaryColor,
                size: size,
                onTap: () {
                  Navigator.pop(context);
                },
                title: 'ACTIVIDADES OFFLINE',
                // user: ctrlHome.getUser!['nombre']
              ),
               Expanded(
                 child: Center(
                   child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              ItemsMenu(
                                onTap: () async{
                                  final crtlAct=context.read<ActividadesController>();

             ProgressDialog.show(context);
            final response = await  crtlAct.buscaActividadesOffLine(context);
            ProgressDialog.dissmiss(context);
            if (response != null  ) {

if (response.isNotEmpty) {
   NotificatiosnService.showSnackBarDanger( 'CORRECTO LLENO');
} else {
  NotificatiosnService.showSnackBarDanger( 'VACIO');
}

    } 
    
     if (response.isEmpty) {
       NotificatiosnService.showSnackBarDanger( 'NO hay datos');
    
    }
                                  
                                },
                               
                                label: 'Desgargar BDD',
                                icon: 'downloadBDD.png',
                                color: Colors.red.shade800,
                              ),
                              ItemsMenu(
                                onTap: () {
                                   final crtlAct=context.read<ActividadesController>();
                                 
                                   crtlAct.setTipoPeticion('PENDIENTE');
                                 
                   crtlAct.fetchActas();
                   Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => ListaOffLineActividadesPendientes())));
                                 
                                },
                               
                                label: 'Pendientes',
                                icon: 'pendientes.png',
                                color: Colors.orange.shade800,
                              ),
                              ItemsMenu(
                                onTap: () {
                                    final crtlAct=context.read<ActividadesController>();
                                   
                                   crtlAct.setTipoPeticion('PROCESADO');
                     crtlAct.fetchActas();
                 
                   Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => ListaOffLineActividadesProcesados())));
                                },
                               
                                label: 'Procesados',
                                icon: 'procesados.png',
                                color: Colors.green.shade800,
                              ),
                              ItemsMenu(
                                onTap: () {
                                 
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>  ListaCoros(user: widget.user,)),
                                  // );
                                },
                               
                                label: 'Subir BDD ',
                                icon: 'uploadData.png',
                                color: Colors.blue.shade800,
                              ),
                            ]),
                 ),
               )
              
            ],
          ),
        ),
       ),
    );
  }
}