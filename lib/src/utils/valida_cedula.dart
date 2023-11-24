Future<bool> validaCedula(String _cedula) async {
    //==== RESET LAS VARIABLES==//
    List<String> _data = [];
    List<int> _dataList = [];
    List<int> dataListProducto = [];
    int _producto;
    int _suma = 0;
    int _residuo;
    int _digito = 0;

    _data = _cedula.split('');
    _dataList = _data.map((e) => int.parse(e)).toList();

    _dataList.asMap().forEach((index, value) {
      if (index % 2 == 0) {
        _producto = value * 2;
        if (_producto > 9) {
          dataListProducto.addAll({_producto - 9});
        } else {
          dataListProducto.addAll({_producto});
        }
      } else {
        dataListProducto.addAll({value * 1});
      }
      // print('Data: ${index}');
    });
    _suma = 0;
    for (var i = 0; i < dataListProducto.length - 1; i++) {
      _suma += dataListProducto[i];
    }
    // print('la suma es : ${_suma}');
    _residuo = _suma % 10;
    // print('_residuo es : ${_residuo}');
    if (_residuo != 0) {
      _digito = 10 - _residuo;
      // print('_digito es : ${_digito}');
    } else if (_residuo == 0) {
      _digito = _residuo;
      // print('_digito es : ${_digito}');
    }
    // print('LISTA es : ${dataListProducto[9]}');
    if (_digito == dataListProducto[9]) {
      // print('CEDULA CORRECTA : ${_digito} == ${dataListProducto[9]}');
      
      return true;
    } else {
      // print('CEDULA NOOOO CORRECTA : ${_digito} == ${dataListProducto[9]}');
      return false;
    }
  }