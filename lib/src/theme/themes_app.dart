//========================================//
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/responsive.dart';


class AppTheme extends ChangeNotifier {
// final BuildContext context;

  bool _darkTheme = false;
  bool _customTheme = false;

  ThemeData? _currentTheme;

  bool get darkTheme => this._darkTheme;
  bool get customTheme => this._customTheme;
  ThemeData? get currentTheme => _currentTheme;

  Color? _primaryTextColor;
  Color? get getPrimaryTextColor => _primaryTextColor;

  void setPrimayText(Color _color) {
    _primaryTextColor = _color;
    notifyListeners();
  }

  Color? _secondaryTextColor;
  Color? get getSecondryTextColor => _secondaryTextColor;

  void setSecondaryText(Color _color) {
    _secondaryTextColor = _color;
    notifyListeners();
  }

  Color? _terciaryTextColor;
  Color? get getTerciaryTextColor => _terciaryTextColor;

  void setTerciaryText(Color _color) {
    _terciaryTextColor = _color;
    notifyListeners();
  }
  ///===== COLORBASE DE LFONDO DEL HOME ====//
  ///
  ///   const Color(0xFF973592).withOpacity(0.5),
                   // const Color(0xFF0092D0)
  ///
  ///
  Color? _colorBase1;//=Color(0xFF973592);
  Color? get getColorsbase1 => _colorBase1;

  void setColorBase1(Color _color) {
    _colorBase1 = _color;
    notifyListeners();
  }
  Color? _colorBase2;//=Color(0xFF0092D0);
  Color? get getColorsbase2 => _colorBase2;

  void setColorBase2(Color _color) {
    _colorBase2 = _color;
    notifyListeners();
  }
 

Responsive? _getSize;

Responsive? get _getResponsiveSize=>_getSize;
void setResponsive(Responsive? _size){
    _getSize=_size;
    print('_getSize:$_getSize');
  }

bool _isTheme=false;

bool get  getIsTheme=>_isTheme;

void setIsTheme(bool _istheme){
  _isTheme=_istheme;
  notifyListeners();
}


  void setAppTheme(bool value, String _tipo, Color _primary, Color _secundary,
      Color _terciadary,Responsive _size) {
    _customTheme = false;
    _darkTheme = value;

    if (value) {
      _isTheme=true;
      _currentTheme = ThemeData.light().copyWith(
        primaryColor: _primary,
        //  primaryColorLight:Colors.red,
        radioTheme: RadioThemeData(
            fillColor: MaterialStateColor.resolveWith((states) => _primary)
            // fillColor:MaterialStateProperty(C);
            ),

        textTheme: TextTheme(
          headline2: GoogleFonts.lexendDeca(
              fontSize: _size.iScreen(2.45),
              color: _secundary,
              fontWeight: FontWeight.normal),
          subtitle1: GoogleFonts.lexendDeca(
              // fontSize: _size.iScreen(1.9),
              color: _terciadary,
              fontWeight: FontWeight.normal),
          subtitle2: GoogleFonts.lexendDeca(
              // fontSize: _size.iScreen(1.9),
              color: _terciadary,
              fontWeight: FontWeight.normal),
          bodyText1: const TextStyle(color: Colors.black87),
          bodyText2: const TextStyle(color: Colors.black87),
          button: const TextStyle(color: Colors.black87),
          caption: const TextStyle(color: Colors.black87),
          headline1: const TextStyle(color: Colors.black87),
          headline3: const TextStyle(color: Colors.black87),
          headline4: const TextStyle(color: Colors.black87),
          headline5: const TextStyle(color: Colors.black87),
          headline6: const TextStyle(color: Colors.black87),
        ),
        // inputDecorationTheme:InputDecorationTheme (
        //   suffixStyle: TextStyle(color:Colors.black),
        //   labelStyle:TextStyle(color:Colors.black),
        // ) ,
        // highlightColor: _terciadary,
        // textTheme: TextTheme(
        //     headline1: TextStyle( color: Colors.red )
        //   ),

        //==== COLOR DEL APPBAR ======//
        appBarTheme: AppBarTheme(
          color: _primary,
          iconTheme: IconThemeData(color: _secundary),
          foregroundColor: _secundary,
          titleTextStyle: TextStyle(
            color: _secundary,
            // fontSize: _size.iScreen(2.45),
          ),
        ),
        //==== COLOR DEL FLOATBUTTOM ======//
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: _primary, foregroundColor: _secundary),

  
      );
      setPrimayText(_primary);
      setSecondaryText(_secundary);
      setTerciaryText(_terciadary);
    } else {
      _currentTheme =ThemeData.light();//_customThemeApp();
      _isTheme=false;
    }

    notifyListeners();
  }

  // // ThemeData _customThemeApp() => ThemeData.light();
  // ThemeData _customThemeApp() => ThemeData.light().copyWith();

  // set customTheme(bool value) {
  //   _customTheme = value;
  //   _darkTheme = false;
  //   if (value) {
  //     _currentTheme = ThemeData.dark();
  //   } else {
  //     _currentTheme = ThemeData.light();
  //   }

  //   // if ( value ) {
  //   //   _currentTheme = ThemeData.dark().copyWith(
  //   //       accentColor: Color(0xff48A0EB),
  //   //       primaryColorLight: Colors.white,
  //   //       scaffoldBackgroundColor: Color(0xff16202B),
  //   //       textTheme: TextTheme(
  //   //         // body1: TextStyle( color: Colors.white )
  //   //       ),
  //   //       // textTheme.body1.color
  //   //   );
  //   // } else {
  //   //   _currentTheme = ThemeData.light();
  //   // }

  //   notifyListeners();
  // }
}






