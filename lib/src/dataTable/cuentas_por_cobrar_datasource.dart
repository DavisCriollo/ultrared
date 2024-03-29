import 'package:flutter/material.dart';


import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

class ListaDeCuentasPorCobrarDS extends DataTableSource {
  final BuildContext context;
  final List _listaCuentasPorCobrar;
  final Responsive size;

  ListaDeCuentasPorCobrarDS(this._listaCuentasPorCobrar, this.size, this.context);


  @override
  DataRow? getRow(int index) {
 final item= _listaCuentasPorCobrar[index];

//  _listaCuentasPorCobrar.sort((a, b) => b['id'].compareTo(a['id']));
    return DataRow.byIndex(
      index: index,
      cells: [
        
        DataCell(Text('$index')),
 
        DataCell(Text(item['ccFechaFactura'] != null && item['ccFechaFactura'].isNotEmpty ? '${item['ccFechaFactura']}' : '--- --- ---')),
        DataCell(Text(item['ccValorFactura'] != null && item['ccValorFactura'].isNotEmpty ? '${item['ccValorFactura']}' : '0.0')),
        DataCell(Text(item['ccAbono'] != 0 ? '${item['ccAbono']}' : '0.0')),
        DataCell(Text(item['ccSaldo'] != null && item['ccSaldo'].isNotEmpty ? '${item['ccSaldo']}' : '0.0')),
        DataCell(
  Text(
    item['ccEstado'] != null && item['ccEstado'].isNotEmpty ? '${item['ccEstado']}' : '--- --- ---',
    style: TextStyle(
      color: item['ccEstado'] == 'CANCELADO' ? Colors.green : colorPrimario,
    ),
  ),
),
        
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
