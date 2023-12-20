


import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';

import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';



class ElementosSOS extends StatelessWidget {
  final String image;
  final bool enabled;
  final String title;
  final String label;
  final Function() onTap;
  const ElementosSOS({
    Key? key,
    required this.size,
    required this.enabled,
    required this.image,
    required this.title, 
    required this.label, 
    required this.onTap,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return 

    Consumer<HomeController> (builder: (_, values, __) { 
      return   InkWell(
     
      // splashColor: Colors.red,
      child: Container(
        margin: EdgeInsets.all(size.iScreen(1)),
        padding: EdgeInsets.all(size.iScreen(0.0)),
        decoration: BoxDecoration(
            color: (enabled == false) ? const Color(0xFFcdd0cb) : Colors.white,
            borderRadius: BorderRadius.circular(size.iScreen(1.0))),
        width:size.iScreen(16.0),
        height: size.iScreen(20),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
            color: (enabled == false) ? const Color(0xFFcdd0cb) : Colors.white,
            borderRadius: BorderRadius.circular(size.iScreen(.0))),
                 width:size.iScreen(17.0),
                padding:EdgeInsets.all(size.iScreen(0.0)),
              child: Container(
                 height: size.iScreen(13.5),

                decoration: BoxDecoration( 
                color: septinaryColor,
                  borderRadius: BorderRadius.circular(size.iScreen(1.0))),
                margin: EdgeInsets.all(size.iScreen(1.0)),
                padding: EdgeInsets.all(size.iScreen(1.0)),
                child: Column(
                  children: [
                    // Image.asset(
                    //   image,
                    //   fit: BoxFit.contain,
                    //   width: size.iScreen(7.0),
                    // ),
                       AvatarGlow(
                          glowRadiusFactor: 0.2,
                glowColor: Colors.red,
                animate: values.alarmActivated== false?false:true,
                         child: Container(
                                           width: size.iScreen(9.0),
                                           height: size.iScreen(9.0),
                                           decoration: BoxDecoration(
                          color: values.alarmActivated== true? Colors.white:Colors.grey,
                          borderRadius: BorderRadius.circular(100)),
                                           margin: EdgeInsets.all(size.iScreen(0.0)),
                                           padding: EdgeInsets.all(size.iScreen(0.0)),
                                           child: Container(
                                             width: size.iScreen(3.0),
                                             height: size.iScreen(3.5),
                                             decoration: BoxDecoration(
                            color:values.alarmActivated== true? Colors.white:tercearyColor,
                            borderRadius: BorderRadius.circular(100)),
                                             margin: EdgeInsets.all(size.iScreen(1.5)),
                                             padding: EdgeInsets.all(size.iScreen(0.5)),
                                             child: Center(
                            child: Text('SOS',
                                style: GoogleFonts.poppins(
                                  fontSize: size.iScreen(2.5),
                                  color: values.alarmActivated== true? Colors.red:Colors.white,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: -0.28,
                                ))),
                                           ),
                                         ),
                       ),
                     Text(title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: size.iScreen(1.5),
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          letterSpacing:  -0.28,
                          )),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
              child: Column(
                children: [
                 
                  Text(values.alarmActivated== true?
                  'Alarma Activada': label,
                  textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: size.iScreen(1.3),
                          color:values.alarmActivated== true?Colors.red: Colors.black,
                          fontWeight:values.alarmActivated== true? FontWeight.w600:FontWeight.normal,
                          letterSpacing:  -0.28,)),
                ],
              ),
            ),
          ],
        )
    
        
        // Consumer<HomeController> (builder: (_, values, __) { 
          
        //   return  
          
          
    
        // },)
        
    
      ),
      onLongPress:values.alarmActivated== true? null :onTap
    );
  
  
      },);
   
  
  
  }
}
