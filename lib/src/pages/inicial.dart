import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/acceso_gps_page.dart';
import 'package:ultrared/src/pages/login_page.dart';
import 'package:ultrared/src/pages/selecciona_sector.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

class Inicial extends StatefulWidget {
  const Inicial({Key? key}) : super(key: key);

  @override
  State<Inicial> createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  @override
  Widget build(BuildContext context) {
     final Responsive size = Responsive.of(context);
     
    return SafeArea(
      child: Scaffold(
        body: 
        Container(
          width: size.wScreen(100),
          height: size.hScreen(100.0),
           decoration: const BoxDecoration(
            // color: Colors.yellow,
            image:  DecorationImage(
             
                image:  AssetImage("assets/imgs/fondoApp.png"),
                fit: BoxFit.fill,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
            height: size.hScreen(25.0), // 20% de la altura total
            // color: Colors.blue,
            child: Image.asset("assets/imgs/logoBlanco.png",scale: size.iScreen(0.7),),
          ),
          Container(
            width: size.wScreen(100.0),
           height: size.hScreen(38.0),// 70% de la altura total
            // color: Colors.green,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
    border: Border.all(color: Colors.white)
  ),

                
                  child: InkWell(
                    splashColor: Colors.amber,
                    highlightColor:Colors.red,

                    onTap: () {
                        // final _ctrlHome= context.read<HomeController>();
                        //         _ctrlHome.resetAllValues();
                        //         _ctrlHome.setItemLugarServicio('HOGAR');
                              
                        //       Navigator.push(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                         builder: ((context) =>
                        //                             const SeleccionaSector(action: 'CREATE',))));

                     
                              
                              Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const AccesoGPSPage(tipo:'CREATE' ,))));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: size.iScreen(6.0),vertical: size.iScreen(1.0)),
                      child: Text('NUEVO USUARIO', textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: size.iScreen(2.1),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                        ),),
                    ),
                  ),
                ),
                SizedBox(height: size.iScreen(4.0),),
                Text('Ya soy cliente', textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: size.iScreen(1.7),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white
                                        ),),
                                        SizedBox(height: size.iScreen(0.5),),
                                        InkWell(
                                          onTap: () {
                                            //   Navigator.push(
                                            // context,
                                            // MaterialPageRoute(
                                            //     builder: ((context) =>
                                            //         LoginPage())));
                                              Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const AccesoGPSPage(tipo:'LOGIN' ,))));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: size.iScreen(4.0),vertical: size.iScreen(1)),
                                            decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20)
                                            ),
                                            
                                            child: Text('INICIA SESIÓN', textAlign: TextAlign.center,
                                                                            style: GoogleFonts.poppins(
                                            fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: colorPrimario
                                            ),),
                                          ),
                                        ),
              ],
            ),
          ),
          Container(
           height: size.hScreen(10.0), // 10% de la altura total
            // color: Colors.red,
               child: Image.asset("assets/imgs/logoPie.png",scale: size.iScreen(0.7)),
          ),
          ],
        )),
      ),
    );
  }
}