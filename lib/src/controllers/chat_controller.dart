
import 'package:flutter/material.dart';


// import 'package:neitor_vet/src/api/api_provider.dart';

class ChatController extends ChangeNotifier {
  List _messages = [];
  List get getMessages => _messages;

  void addMessage(message) {
    // _messages.insert(0, {
    //   message
    
    // });
    print('----> ${message}');
    notifyListeners();
  }

  String _cajaTextoChat = '';
  String get getCajaTextoChat => _cajaTextoChat;

  void setCajaText(String _value) {
    _cajaTextoChat = _value;
    print(_cajaTextoChat);
    notifyListeners();
  }




  // void stopPlayback() async {
  //   await _player._closeAudioSession();
  // }

  // @override
  // void dispose() {
  //   _player._closeAudioSession();
  //   _recorder._closeAudioSession();
  //   super.dispose();
  // }





}
