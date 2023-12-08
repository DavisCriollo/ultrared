import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/pages/acercaDe.dart';
import 'package:ultrared/src/pages/lista_notificaciones.dart';
import 'package:ultrared/src/pages/login_page.dart';
import 'package:ultrared/src/pages/ser_cliente_page.dart';
import 'package:ultrared/src/pages/splash_screen.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

class DrawerMenu extends StatelessWidget {
  final Map<String, dynamic>? user;

  const DrawerMenu({Key? key, required this.user}) : super(key: key);
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
                user!['foto'].isNotEmpty
                    ? Container(
                        width: size.iScreen(9.0),
                        height: size.iScreen(9.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 2.0),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                '${user!['foto']}', // Reemplaza con la URL de tu imagen
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ))
                    : ClipOval(
                        child: Image.asset(
                          'assets/imgs/no-image.png', // Reemplaza con la ruta de tu imagen en los activos
                          width: size.iScreen(7.5),
                          height: size.iScreen(7.5),
                          fit: BoxFit.cover,
                        ),
                      ),
                Container(
                  width: size.wScreen(80.0),
                  child: Text(
                    '${user!['nombre']}',
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
                        ' ID ',
                        style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Text(
                        '${user!['id']}  ',
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ListaNotificaciones())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title:  const Text('Compartir'),
            onTap: () {
              // Acción al hacer clic en "Configuración"
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Acerca de'),
            onTap: () {
              // Acción al hacer clic en "Acerca de"
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => AcercaDePage())));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar Sesión'),
            onTap: () async {
              context.read<SocketModel>().disconnectSocket();
              // Acción al hacer clic en "Salir"
              // Navigator.pop(context);
              await Auth.instance.deleteTokenFireBase();
              await Auth.instance.deleteSesion(context);

              // Navigator.push(context,
              //     MaterialPageRoute(builder: ((context) => SplashPage())));

              Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => SerClientePage(
                        // validaTurno: validaTurno,
                        // tipo: session.rol,
                        // user: session,
                        // ubicacionGPS: controllerHome.getCoords,
                      )),
              (Route<dynamic> route) => false);
          ModalRoute.withName('/');


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
