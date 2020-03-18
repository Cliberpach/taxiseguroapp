import 'package:flutter/material.dart';
import 'package:gpsadmin/models/user.dart';

class AuthViewModel extends ChangeNotifier {
  User _user;

  User get user => _user;

  setUser(User _u) {
    _user = _u;
    notifyListeners();
  }
}
