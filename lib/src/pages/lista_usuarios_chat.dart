import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/pages/chat_page.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

class ListaUsuariosChat extends StatefulWidget {
  const ListaUsuariosChat({Key? key}) : super(key: key);

  @override
  State<ListaUsuariosChat> createState() => _ListaUsuariosChatState();
}

class _ListaUsuariosChatState extends State<ListaUsuariosChat> {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: cuaternaryColor,
        appBar: AppBar(
          iconTheme: const IconThemeData( color: Colors.black),
           centerTitle: true, // Centra el título en el AppBar
          elevation: 0,
          backgroundColor: cuaternaryColor, // Fondo blanco
          title: Text('"LOS VÉLEZ"',
              style: GoogleFonts.poppins(
                fontSize: size.iScreen(2.0),
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.40,
              ) // Color del título en negro
              ),
        ),
        body: Stack(
          children: [
            Container(
                // alignment: Alignment.center,
                // color: Colors.red,

                width: size.wScreen(100.0),
                height: size.hScreen(100.0),
                child: ListView.builder(
                  shrinkWrap:true ,
            itemCount: 50,
            itemBuilder: (context, index) {
              return 
              Column(
                children: [
                  ListTile(
                    dense: true,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        alignment:  Alignment.center,
                        width: size.iScreen(5.0),
                height: size.iScreen(5.0),
                          // decoration:  BoxDecoration(borderRadius: BorderRadius.circular(100),
                          // color:  Colors.red
                          // ),
                        child: Image.asset(
                                        'assets/imgs/Avatar.png',
                                        // scale: 1.5,
                                        fit: BoxFit.contain,
                                        width: size.iScreen(5.0),
                                        scale: 1.0, // URL de la imagen
                                      ),
                        // CachedNetworkImage(
                        //                               imageUrl: 'https://www.recetasnestle.com.mx/sites/default/files/inline-images/comidas-fritas-plato-apanado-ensalada.jpg',
                        //                               fit: BoxFit.contain,
                        //                               placeholder: (context,
                        //                                       url) =>
                        //                                   const CupertinoActivityIndicator(),
                        //                               // Image.asset(
                        //                               //     'assets/imgs/loader.gif'),
                    
                        //                               errorWidget: (context, url,
                        //                                       error) =>
                        //                                   const Icon(Icons.error),
                        //                             ),
                      ),
                    ),
                    title: Text('Pedro Cevallos',
                    style: GoogleFonts.poppins(
                    fontSize: size.iScreen(1.8),
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    letterSpacing: -0.40,
                  ) ),
                    subtitle: Text('Disponible',
                    ),
                    onTap: () {
                      // Acción al hacer clic en el ListTile
                      print('Clic en el ListTile $index');
                    },
                    trailing:  Text('11:35',style: GoogleFonts.poppins(
                    fontSize: size.iScreen(1.6),
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    // letterSpacing: -0.40,
                  )),
                  ),
                Divider()
                ],
              );
       
            },
      )),
      Positioned(
        bottom: size.wScreen(0),
        right: size.wScreen(2.0),
        child:   GestureDetector(
          onTap: () =>  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                               ChatPage()))),
          child: Container(
            width: size.wScreen(25.0),
            height: size.hScreen(6.0),
            padding:  EdgeInsets.all(size.iScreen(1.0)),
            decoration: ShapeDecoration(
              color: Color(0xFFB32623),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x33123B93),
                  blurRadius: 20,
                  offset: Offset(8, 8),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Center(
              child: Text(
                'Ir al Chat',
                textAlign: TextAlign.center,
                style:GoogleFonts.poppins(
                      fontSize: size.iScreen(1.5),
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      // letterSpacing: -0.40,
                    ),
              ),
            ),
          ),
        ),)
          ],
        ),
    
      ),
    );
  }
}
