import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

class DataTableEstadoCuenta extends StatelessWidget {
  const DataTableEstadoCuenta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final Responsive size = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true, // Centra el título en el AppBar
          elevation: 0,
          backgroundColor: cuaternaryColor, // Fondo blanco
          title: Text('Estado de Cuenta',
              style: GoogleFonts.poppins(
                fontSize: size.iScreen(2.0),
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.40,
              ) // Color del título en negro
              ),
        ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Num')),
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Valor')),
          DataColumn(label: Text('Fecha')),
          // Add more DataColumn widgets for additional columns
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('1')),
            DataCell(Text('Raul')),
            DataCell(Text('\$100')),
            DataCell(Text('2022-01-01')),
            // Add more DataCell widgets for additional columns
          ]),
          DataRow(cells: [
            DataCell(Text('2')),
            DataCell(Text('María')),
            DataCell(Text('\$200')),
            DataCell(Text('2022-02-01')),
            // Add more DataCell widgets for additional columns
          ]),
          DataRow(cells: [
            DataCell(Text('3')),
            DataCell(Text('Pedro')),
            DataCell(Text('\$100')),
            DataCell(Text('2022-01-01')),
            // Add more DataCell widgets for additional columns
          ]),
          DataRow(cells: [
            DataCell(Text('4')),
            DataCell(Text('Juan')),
            DataCell(Text('\$200')),
            DataCell(Text('2022-02-01')),
            // Add more DataCell widgets for additional columns
          ]),
         
          DataRow(cells: [
            DataCell(Text('5')),
            DataCell(Text('Esperanza Molina')),
            DataCell(Text('\$200')),
            DataCell(Text('2022-02-01')),
            // Add more DataCell widgets for additional columns
          ]),
          DataRow(cells: [
            DataCell(Text('6')),
            DataCell(Text('Lorena')),
            DataCell(Text('\$100')),
            DataCell(Text('2022-01-01')),
            // Add more DataCell widgets for additional columns
          ]),
          DataRow(cells: [
            DataCell(Text('7')),
            DataCell(Text('Ernesto')),
            DataCell(Text('\$200')),
            DataCell(Text('2022-02-01')),
            // Add more DataCell widgets for additional columns
          ]),
           DataRow(cells: [
            DataCell(Text('9')),
            DataCell(Text('Sofía Mendoza')),
            DataCell(Text('\$100')),
            DataCell(Text('2022-01-01')),
            // Add more DataCell widgets for additional columns
          ]),
          // Add more DataRow widgets for additional rows
        ],
      ),
    ),
    );
  }
}