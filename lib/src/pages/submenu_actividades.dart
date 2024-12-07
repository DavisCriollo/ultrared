import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/actividades_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';

import 'package:ultrared/src/pages/listar_actividades_pendientes.dart';
import 'package:ultrared/src/pages/listar_actividades_procesadas.dart';
import 'package:ultrared/src/pages/menu_actividades.dart';
import 'package:ultrared/src/pages/menu_offline.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';
import 'package:ultrared/src/widgets/items_menu.dart';


class SubMenuActividades extends StatelessWidget {
    final Map<String, dynamic>? user;
  const SubMenuActividades({Key? key, this.user}) : super(key: key);



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
               
                title: 'ACTIVIDADES',
                // user: ctrlHome.getUser!['nombre']
              ),
               Expanded(
                 child: Center(
                   child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              ItemsMenu(
                                onTap: () {
                                 
                      Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => MenuOffLine())));
                                },
                               
                                label: 'Actividades Offline',
                                icon: 'no-internet.png',
                                color: Colors.red.shade800,
                              ),
                              ItemsMenu(
                                onTap: () {
                                   final crtlAct=context.read<ActividadesController>();
                                   crtlAct.setTipoPeticion('PENDIENTE');
                                  //  crtlAct.setTipoPeticion('PROCESADO');
                 
                 
                   Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => MenuActividades())));
                                 
                                },
                               
                                label: 'Actividades Online',
                                icon: 'global-access.png',
                                color: Colors.green,
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