import 'package:flutter/material.dart';
import 'package:gpsadmin/models/vehiculo.dart';

class DeviceViewModel extends ChangeNotifier {
  Vehiculo _vehiculo;


  Vehiculo get vehiculo => _vehiculo;

  setvehiculo(Vehiculo _v) {
    _vehiculo = _v;
    notifyListeners();
  }
}

