import 'package:flutter/material.dart';


import 'package:ultrared/src/utils/responsive.dart';

class ListaDeCuentasPorCobrarDS extends DataTableSource {
  final BuildContext context;
  final List _listaCuentasPorCobrar;
  final Responsive size;

  ListaDeCuentasPorCobrarDS(this._listaCuentasPorCobrar, this.size, this.context);


  @override
  DataRow? getRow(int index) {


//  _listaCuentasPorCobrar.sort((a, b) => b['id'].compareTo(a['id']));
    return DataRow.byIndex(
      index: index,
      cells: [
        
        DataCell(Text('$index')),
        DataCell(Text(_listaCuentasPorCobrar[index]['ccFechaFactura'] ?? '--- --- ---'),),
        DataCell(Text(_listaCuentasPorCobrar[index]['ccValorFactura']?? '0.0')),
        DataCell(Text(_listaCuentasPorCobrar[index]['ccAbono']?? '0.0')),
        DataCell(Text(_listaCuentasPorCobrar[index]['ccSaldo']?? '0.0')),
        DataCell(Text(_listaCuentasPorCobrar[index]['ccEstado']?? '--- --- ---')),
        
      ],
   
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _listaCuentasPorCobrar.length;

  @override
  int get selectedRowCount => 0;
}
