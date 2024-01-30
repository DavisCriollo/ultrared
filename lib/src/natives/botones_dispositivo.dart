
import 'package:flutter/services.dart';

class BotonesChannel{
  final MethodChannel _methodChannel = const MethodChannel('app/neitor/botones?channel');
  

Future<void>  versionSO() async{
 try {
    final result = await _methodChannel.invokeMethod("versionSO");
  print('El resiltado de Channel> $result');
 } catch (e) {
   print('Error Channel Botones  $e');
 }
}

}