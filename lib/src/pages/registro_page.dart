import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/selecciona_planes_page.dart';
import 'package:ultrared/src/pages/selecciona_sector.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/letras_mayusculas_minusculas.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/utils/valida_email.dart';
import 'package:ultrared/src/widgets/botonBase.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  TextEditingController _textAddTelefono = TextEditingController();
  TextEditingController _textAddCorreo = TextEditingController();
  TextEditingController controllerTextCountry = TextEditingController();
  bool _isChecked = false;

  @override
  void dispose() {
    _textAddCorreo.clear();
    _textAddTelefono.clear();
    controllerTextCountry.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _control = context.read<HomeController>();
    // context.read<SocketService>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: cuaternaryColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
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
                    height: size.iScreen(0.0),
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
                          height: size.iScreen(0.5),
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

                                  // border: Border.all(
                                  //   color: Colors.grey,
                                  //   width: 1.0,
                                  // ),
                                ),
                                child:

                                    // TextFormField(

                                    //   decoration: const InputDecoration(
                                    //     suffixIcon: Icon(Icons.assignment_ind),
                                    //     hintText: 'CÉDULA',
                                    //     border: InputBorder.none,
                                    //   ),
                                    //   keyboardType: TextInputType.number,
                                    //   inputFormatters: <TextInputFormatter>[
                                    //     FilteringTextInputFormatter.allow(
                                    //         RegExp(r'[0-9]')),
                                    //   ],
                                    //   onChanged: (text) {
                                    //     _control.setItemCedua(text.trim());

                                    //   },
                                    // ),
                                    Container(
                                  width: size.wScreen(100.0),
                                  child: TextFormField(
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    decoration: InputDecoration(
                                      suffixIcon:
                                          const Icon(Icons.assignment_ind),
                                      hintText: 'CÉDULA',
                                      // border: InputBorder.none,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10.0, 15.0, 0.0, 0.0),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),

                                      // labelText: 'Nome',
                                    ),
                                    onChanged: (text) {
                                      _control.setItemCedua(text.trim());
                                    },
                                  ),
                                )),
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
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.person),
                                  hintText: 'NOMBRES',
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  _control.setItemNombre(text.trim());
                                },
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
                                onChanged: (text) {
                                  _control.setItemApellido(text.trim());
                                },
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
                                  suffixIcon: Icon(Icons.directions),
                                  hintText: 'DIRECCIÒN',
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  _control.setItemDireccion(text.trim());
                                },
                              ),
                            ),
                          ),
                        ),
                        //***********************************************/

                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),

                        //***********************************************/
                        //***********************************************/
                        GestureDetector(
                          onTap: () {
                            _agregaCorreo(context, _control, size);
                          },
                          child: Container(
                              width: size.wScreen(80.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(2.0),
                                  vertical: size.iScreen(1.0)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: Consumer<HomeController>(
                                builder: (_, valuCorreo, __) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        // color: Colors.red,
                                        width: size.wScreen(60.0),
                                        child: valuCorreo.getItemCorreos == ""
                                            ? Text(
                                                ' EMAIL  ',
                                                style: GoogleFonts.poppins(
                                                  fontSize: size.iScreen(
                                                      2.0), // Ajusta según tus necesidades
                                                  fontWeight: FontWeight.w400,
                                                  color: valuCorreo
                                                              .getItemCorreos !=
                                                          ""
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              )
                                            : Text(
                                                '${valuCorreo.getItemCorreos}  ',
                                                style: GoogleFonts.poppins(
                                                  fontSize: size.iScreen(
                                                      2.0), // Ajusta según tus necesidades
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5,
                                                  color: valuCorreo
                                                              .getItemCorreos !=
                                                          ""
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              ),
                                      ),
                                      Icon(
                                        Icons
                                            .email_outlined, // Cambia el icono según tus necesidades
                                        color: valuCorreo.getItemCelulars == ""
                                            ? Colors.black45
                                            : tercearyColor, // Color del icono
                                      ),
                                    ],
                                  );
                                },
                              )),
                        ),
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),

                        //***********************************************/

                        //***********************************************/
                        GestureDetector(
                          onTap: () {
                            _agregaCelular(context, _control, size);
                          },
                          child: Container(
                              width: size.wScreen(80.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(2.0),
                                  vertical: size.iScreen(1.0)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: Consumer<HomeController>(
                                builder: (_, valuCelular, __) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        // color: Colors.red,
                                        width: size.wScreen(60.0),
                                        child: valuCelular.getItemCelulars == ""
                                            ? Text(
                                                'CELULAR  ',
                                                style: GoogleFonts.poppins(
                                                  fontSize: size.iScreen(
                                                      2.0), // Ajusta según tus necesidades
                                                  fontWeight: FontWeight.w400,
                                                  color: valuCelular
                                                              .getItemCelulars !=
                                                          ""
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              )
                                            : Text(
                                                '${valuCelular.getItemCelulars}  ',
                                                style: GoogleFonts.poppins(
                                                  fontSize: size.iScreen(
                                                      2.0), // Ajusta según tus necesidades
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5,
                                                  color: valuCelular
                                                              .getItemCelulars !=
                                                          ""
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              ),
                                      ),
                                      Icon(
                                        Icons
                                            .stay_current_portrait_outlined, // Cambia el icono según tus necesidades
                                        color: valuCelular.getItemCelulars == ""
                                            ? Colors.grey
                                            : tercearyColor, // Color del icono
                                      ),
                                    ],
                                  );
                                },
                              )),
                        ),

                        //***********************************************/
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/

                        //***********************************************/

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

                                    _control.setItemIsEdad(_isChecked);
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

                        GestureDetector(
                          onTap: () {
                            _next(context, _control);
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

  Future<bool?> _agregaCelular(
      BuildContext context, HomeController controller, Responsive size) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
            title: Container(child: const Text("AGREGAR CELULAR")),
            content: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Form(
                key: controller.celularFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: size.iScreen(100.0),
                      child: Container(
                        // width: size.wScreen(45.0),
                        child: IntlPhoneField(
                          initialCountryCode: 'EC',
                          autofocus: true,
                          controller: controllerTextCountry,
                          decoration: const InputDecoration(),
                          style: TextStyle(color: Colors.black),

//  initialCountryCode: 'EC',

                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onChanged: (phone) {
                            print(phone.completeNumber);
                            controller.seItemCelulars(phone.completeNumber);
                          },
                          onCountryChanged: (country) {
                            controller.seItemCodeCelular(country.dialCode);
                          },
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          controller.seItemCelulars(controller.getItemCelulars );
                              // .replaceAll('+593', '0'));

                          final isValidS = controller.validateFormCelular();
                          if (!isValidS) return;
                          if (isValidS) {
                            controllerTextCountry.text = '';
                            // controller.agregaListaCelulares();
                            Navigator.pop(context);
                          }
                          //  print(countries.firstWhere((element) => element['code'] == phone.countryISOCode)['max_length']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: tercearyColor,
                              borderRadius: BorderRadius.circular(5.0)),
                          // color: primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: size.iScreen(0.5),
                              horizontal: size.iScreen(0.5)),
                          child: Text('Agregar',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        ))
                  ],
                ),
              ),
            )

            //  },)

            );
      },
    );
  }

  Future<bool?> _agregaCorreo(
      BuildContext context, HomeController controller, Responsive size) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
            title: Container(child: const Text("AGREGAR CORREO")),
            content: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Form(
                key: controller.correoFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: size.iScreen(100.0),
                      child: Container(
                        // width: size.wScreen(45.0),
                        child:
                            // IntlPhoneField(
                            //   controller: controllerTextCountry,
                            //   decoration: const InputDecoration(

                            //       // labelText: 'Phone Number',
                            //       // border: OutlineInputBorder(
                            //       //   // borderSide: BorderSide(),
                            //       // ),
                            //       ),
                            //   onChanged: (phone) {
                            //     print(phone.completeNumber);
                            //     controller.seItemAddCelulars(phone.completeNumber);
                            //   },
                            //   onCountryChanged: (country) {
                            //     controller.seItemCodeCelular(country.dialCode);
                            //   },
                            // ),
                            //===============================================//
                            SizedBox(
                          width: size.iScreen(40.0),
                          child: TextFormField(
                            controller: _textAddCorreo,

                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,

                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              final validador = validateEmail(value);
                              if (validador == null) {
                                controller.setIsCorreo(true);
                              }
                              return validateEmail(value);
                            },
                            decoration: const InputDecoration(
                                hintText: '  Ingrese un Correo'
                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                ),
                            inputFormatters: [
                              LowerCaseText(),
                            ],
                            textAlign: TextAlign.center,
                            style: const TextStyle(

                                // fontSize: size.iScreen(3.5),
                                // fontWeight: FontWeight.bold,
                                // letterSpacing: 2.0,
                                ),
                            onChanged: (text) {
                              controller.setItemCorreos(text);
                              // final _estado=
                              // valueCantidad.validaStock(text);
                              // if(_estado==true){
                              // print('@VERDADERO@ $_estado');

                              // }else{
                              // print('@FALSE@ $_estado');

                              // }
                            },
                            // validator: (text) {
                            //   if (text!.trim().isNotEmpty) {
                            //     return null;
                            //   } else {
                            //     return 'Cantidad inválida';
                            //   }
                            // },
                          ),
                        ),
                        //===============================================//
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          final isValidS = controller.validateFormCorreo();
                          if (!isValidS) return;
                          if (isValidS) {
                            _textAddCorreo.text = '';
                            // controller.agregaListaCorreos();
                            Navigator.pop(context);
                          }
                          //  print(countries.firstWhere((element) => element['code'] == phone.countryISOCode)['max_length']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: tercearyColor,
                              borderRadius: BorderRadius.circular(5.0)),
                          // color: primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: size.iScreen(0.5),
                              horizontal: size.iScreen(0.5)),
                          child: Text('Agregar',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        ))
                  ],
                ),
              ),
            )

            //  },)

            );
      },
    );
  }

  void _next(BuildContext context, HomeController controller) {
    if (controller.getItemCedua!.isEmpty ||
        controller.getItemCedua!.length < 10 ||
        controller.getItemCedua!.length > 10) {
      NotificatiosnService.showSnackBarDanger('Cédula incorrecta');
    } else if (controller.getItemNombre!.isEmpty ||
        controller.getItemApellido!.isEmpty ||
        controller.getItemDireccion!.isEmpty ||
        controller.getItemCorreos!.isEmpty |
            controller.getItemCelulars!.isEmpty ||
        controller.getItemIsEdad == false) {
      NotificatiosnService.showSnackBarDanger('Falta agregar  información');
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => SeleccionaSector())));
    }
  }
}
