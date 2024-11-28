import 'package:intl/intl.dart';

String convertirFechaLocal(String fechaUtc) {
  // Parsear la fecha en UTC
  DateTime dateTimeUtc = DateTime.parse(fechaUtc);

  // Convertirla a hora local
  DateTime dateTimeLocal = dateTimeUtc.toLocal();

  // Formatear la fecha y hora local como 'YYYY-MM-dd HH:mm'
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTimeLocal);

  return formattedDate;
}