import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/service/socket_service.dart';

// class AuthProvider with ChangeNotifier {
//   bool _isAuthenticated = false;

//   bool get isAuthenticated => _isAuthenticated;

//   void authenticateUser(String username, String userId) {
//     _isAuthenticated = true;

//     final socketService = Provider.of<SocketService>(navigatorKey.currentContext, listen: false);
//     socketService.disconnectSocket();
//     socketService.connectSocket(username, userId);

//     notifyListeners();
//   }

//   void logoutUser() {
//     _isAuthenticated = false;

//     final socketService = Provider.of<SocketService>(navigatorKey.currentContext, listen: false);
//     socketService.disconnectSocket();

//     notifyListeners();
//   }
// }
