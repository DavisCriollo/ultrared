//========================== CALCULA FECHA EDAD =======================//

Future<List> calculaEdad(String _fecha) async {
  List _data = [];
  var fNacimiento = DateTime.parse(_fecha);
  var fActual = DateTime.now();

  var yearAct = fActual.year;
  var mesAct = fActual.month;
  var dayAct = fActual.day;

  var year = 0;
  var month = 0;
  var day = 0;

  if (dayAct - fNacimiento.day >= 0) {
    day = (dayAct - fNacimiento.day);
  } else if (dayAct - fNacimiento.day < 0) {
    day = 0;
  } else {
    day = (dayAct + 30 - fNacimiento.day);
    mesAct--;
  }
  if (mesAct - fNacimiento.month >= 0) {
    month = (mesAct - fNacimiento.month);
  } else if (mesAct - fNacimiento.month < 0) {
    month = 0;
  } else {
    month = (mesAct + 12 - fNacimiento.month);
    yearAct--;
  }

  if (yearAct - fNacimiento.year < 0) {
    year = 0;
  } else {
    year = yearAct - fNacimiento.year;
  }

  _data.addAll([year, month, day]);

// print('TIENES: $year ANIOS - $month MESES Y $day dias');
// print('ESTA ES LA LISTA :$_data');

  return _data;
}


//=====================================================================//