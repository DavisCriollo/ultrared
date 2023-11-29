import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/pages/selecciona_planes_page.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
    bool _isChecked = false;
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
          title: Text('REGISTRO',
              style: GoogleFonts.poppins(
                fontSize: size.iScreen(2.0),
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.40,
              ) // Color del título en negro
              ),
        ),
        body: Container(
            // alignment: Alignment.center,
            // color: Colors.red,

            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.hScreen(8),
                    width: size.wScreen(100),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),

                    // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                    child: Image.asset(
                      'assets/imgs/LetrasNegro.png',
                      fit: BoxFit.contain, // URL de la imagen
                    ),
                  ),
                  //***********************************************/

                  SizedBox(
                    height: size.iScreen(3.0),
                  ),
                  //*****************************************/
                  Container(
                    // height: size.hScreen(40),
                    width: size.wScreen(100),
                    // color: Colors.green, // Puedes ajustar el color según tus preferencias
                    // Puedes agregar contenido adicional en este contenedor
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.hScreen(2.0),
                        ),
                        SizedBox(
                          width: size.wScreen(80),
                          height: size.hScreen(8.0),
                          child: Text(
                            'Internet por Fibra Óptica',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: size.iScreen(2.5),
                                fontWeight: FontWeight.w500,
                                color: secondaryColor),
                          ),
                        ),
                        //***********************************************/

                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        Container(
                          // color: Colors.red,
                          width: size.wScreen(80.0),
                          padding: EdgeInsets.all(size.wScreen(0.0)),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric( horizontal: size.hScreen(2.0),
                                  vertical: size.iScreen(0.0)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: TextFormField(
                                // maxLength: 1,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.assignment_ind),
                                  hintText: 'CÉDULA',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //***********************************************/
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        Container(
                          // color: Colors.red,
                          width: size.wScreen(80.0),
                          padding: EdgeInsets.all(size.wScreen(0.0)),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.hScreen(2.0),
                                  vertical: size.iScreen(0.0)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: TextFormField(
                                // maxLength: 1,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.person),
                                  hintText: 'NOMBRES',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //***********************************************/
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        Container(
                          // color: Colors.red,
                          width: size.wScreen(80.0),
                          padding: EdgeInsets.all(size.wScreen(0.0)),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.hScreen(2.0),
                                  vertical: size.iScreen(0.0)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: TextFormField(
                                // maxLength: 1,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.person),
                                  hintText: 'APELLIDOS',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //***********************************************/
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        Container(
                          // color: Colors.red,
                          width: size.wScreen(80.0),
                          padding: EdgeInsets.all(size.wScreen(0.0)),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.hScreen(2.0),
                                  vertical: size.iScreen(0.0)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: TextFormField(
                                // maxLength: 1,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                      Icons.stay_current_portrait_outlined),
                                  hintText: 'CELULAR',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //***********************************************/

                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        Container(
                          // color: Colors.red,
                          width: size.wScreen(80.0),
                          padding: EdgeInsets.all(size.wScreen(0.0)),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(  horizontal: size.hScreen(2.0), vertical: size.iScreen(0.0)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: TextFormField(
                                // maxLength: 1,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.email),
                                  hintText: 'EMAIL',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        // Container(
                        //     // color: Colors.red,
                        //     width: size.wScreen(80.0),
                        //     padding: EdgeInsets.all(size.wScreen(0.0)),
                        //     child: Text(
                        //       'Confirmo que soy mayor de 18 años.',
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 14,
                        //         fontFamily: 'Poppins',
                        //         fontWeight: FontWeight.w400,
                        //         height: 0,
                        //       ),
                        //     )),
                         SizedBox(
                          width: size.wScreen(80),
                          height: size.hScreen(8.0),
                          child: Row(
                            children: [
                             Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
                              Text(
                                'Confirmo que soy mayor de 18 años.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: size.iScreen(1.5),
                                    fontWeight: FontWeight.w400,
                                    color: secondaryColor),
                              ),
                            ],
                          ),
                        ),
                        //***********************************************/
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(3.0),
                        ),
                        //*****************************************/
                        //***********************************************/

                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        GestureDetector(
                           onTap:(){
                        Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              SeleccionaPlanPage())));
                      },
                          child: BotonBase(
                            size: size,
                            label: 'SIGUIENTE',
                          ),
                        ),

                        SizedBox(
                          height: size.hScreen(5.0),
                        ),
                       
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
