import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gpsadmin/models/vehiculo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import '../Utils/globals.dart' as globals;

Future<List<Vehiculo>> listDevice(
    String _token, int _id, BuildContext context) async {
  globals.listdevice = new List<Vehiculo>();
  print(_id.toString() + " " + _token);
  var response = await http.get(
      'http://www.gpsaseguro.com/api/v1/auth/device/byClient/$_id',
      headers: {'Authorization': 'Bearer $_token'});
  var datos = json.decode(utf8.decode(response.bodyBytes));
  
  String revisa;
  globals.apagado = 0;
  globals.movi = 0;
  globals.detenido = 0;
  globals.allMarkers.clear();
  for (int carro = 0; carro < datos.length; carro++) {
    
    globals.listdevice.add(Vehiculo(   //para tener la lista global en toda la aplicacion
        id: datos[carro]["id"].toString(),
        estate: datos[carro]["certificado"],
        placa: datos[carro]["placa"],
        marca: datos[carro]["marca"],
        modelo: datos[carro]["modelo"],
        color: datos[carro]["color"],
        lat: datos[carro]["serial_motor"],
        lng: datos[carro]["numero_serie"],
        phone: datos[carro]["phone"]));

    globals.allMarkers.add(
      Marker(
          icon: globals.myIcon,
          markerId: MarkerId(datos[carro]["placa"]),
          infoWindow: InfoWindow(
            title: datos[carro]["placa"] + ".." + datos[carro]["certificado"],
            snippet: "ASEGURO",
          ),
          draggable: true,
          onTap: () {},
          position: LatLng(double.parse(datos[carro]["serial_motor"]),
              double.parse(datos[carro]["numero_serie"]))),
    );
    //logica para calcular l¿mas al norte
   
    revisa = datos[carro]["certificado"];  //aqui cunto los estados 1 x 1
    switch (revisa) {
      case 'APAGADO':
        globals.apagado = globals.apagado + 1;
        break;
      case 'MOVIMIENTO':
        globals.movi = globals.movi + 1;
        break;
      case 'DETENIDO':
        globals.detenido = globals.detenido + 1;
        break;
    }
    if (globals.latNor==-100) {
if (double.parse(datos[carro]["serial_motor"])>globals.latNor){
        globals.latNor=double.parse(datos[carro]["serial_motor"]);
         globals.lngNor=double.parse(datos[carro]["numero_serie"]);
    }
     if (double.parse(datos[carro]["serial_motor"])<globals.latSur){
        globals.latSur=double.parse(datos[carro]["serial_motor"]);
         globals.lngSur=double.parse(datos[carro]["numero_serie"]);
    }
    }
    
     
  }
  print(globals.latNor);
  print(globals.lngNor);
  print(globals.latSur);
  print(globals.lngSur);

  

  return globals.listdevice;
}
