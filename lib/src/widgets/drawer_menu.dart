import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/pages/login_page.dart';
import 'package:ultrared/src/pages/ser_cliente_page.dart';
import 'package:ultrared/src/pages/splash_screen.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color:
                  tercearyColor, // Puedes ajustar el color del encabezado según tus preferencias
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/imgs/Avatar.png', // Reemplaza con la ruta de tu imagen en los activos
                  width: size.iScreen(9.0),
                  height: size.iScreen(9.0),
                  fit: BoxFit.cover,
                ),
                // SizedBox(height: size.w),
                Container(
                  width: size.wScreen(80.0),
                  child: Text(
                    'Pedro Cevallos',
                    overflow: TextOverflow.ellipsis,
                    // maxLines: 2,

                    style: GoogleFonts.poppins(
                        fontSize: size.iScreen(1.8),
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  padding: EdgeInsets.all(2.0),
                  // width: size.wScreen(20),
                  constraints: BoxConstraints(minWidth: size.iScreen(1.0)),
                  decoration: BoxDecoration(
                    color: Colors
                        .white, // Puedes ajustar el color del contenedor según tus preferencias
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ID ',
                        style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Text(
                        '2550  ',
                        style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              // Acción al hacer clic en "Inicio"
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt_outlined),
            title: Text('Estado de Cuenta'),
            onTap: () {
              // Acción al hacer clic en "Inicio"
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_active),
            title: Text('Notificaciones'),
            onTap: () {
              // Acción al hacer clic en "Configuración"
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Compartir'),
            onTap: () {
              // Acción al hacer clic en "Configuración"
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Acerca de'),
            onTap: () {
              // Acción al hacer clic en "Acerca de"
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar Sesión'),
            onTap: ()  async{
              // Acción al hacer clic en "Salir"
              // Navigator.pop(context);
                                await Auth.instance.deleteTokenFireBase();
                await Auth.instance.deleteSesion(context);
              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SplashPage())));
            },
          ),
           //***********************************************/

                  SizedBox(
                    height: size.iScreen(3.0),
                  ),
                  //*****************************************/
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
  width: size.wScreen(100),
  // height: 19,
  child: Text(
    'Versión 1.0.0',
    textAlign: TextAlign.left,
   style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.w700,
                            color: secondaryColor,
                            height: 0.21),
  ),
)
        ],
      ),
    );
  }
}
