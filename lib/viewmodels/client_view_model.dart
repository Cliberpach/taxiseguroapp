import 'package:flutter/material.dart';
import 'package:gpsadmin/models/client.dart';

class ClientViewModel extends ChangeNotifier {
  Client _client;


  Client get client => _client;

  setclient(Client _c) {
    _client = _c;
    notifyListeners();
  }
}

