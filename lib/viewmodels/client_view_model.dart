import 'package:flutter/material.dart';
import 'package:gpsadmin/models/client.dart';

class ClientViewModel extends ChangeNotifier {
  Cliente _client;

  Cliente get client => _client;

  void setclient(Cliente _c) async {
    _client = _c;
    notifyListeners();
  }
}
