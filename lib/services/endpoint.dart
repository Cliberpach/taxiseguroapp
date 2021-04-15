import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsadmin/models/client.dart';
import 'package:gpsadmin/models/notification.dart';
import 'package:gpsadmin/models/usuario.dart';
import 'package:gpsadmin/models/vehiculo.dart';
import 'package:gpsadmin/viewmodels/client_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Apis {
  String domain = 'https://aseguroperu.com/';

  Future<String> getroute(LatLng origin, LatLng destination) async {
    print('===========LALA API GOOGLE');
    var response = await http.get(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=side_of_road:${destination.latitude},${destination.longitude}&key=AIzaSyAS6qv64RYCHFJOygheJS7DvBDYB0iV2wI');
    if (response.statusCode == 200) {
      var resultado =
          jsonDecode(response.body)["routes"][0]["overview_polyline"]["points"];

      return resultado;
    } else {
      return 'No se encontro direccion';
    }
  }

  Future<String> getdirection(String latitude, String longitude) async {
    print('===========LALA API GOOGLE');
    var response = await http.get(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAS6qv64RYCHFJOygheJS7DvBDYB0iV2wI');
    if (response.statusCode == 200) {
      var resultado =
          jsonDecode(response.body)["results"][0]["formatted_address"];
      print(resultado);
      return resultado;
    } else {
      return 'No se encontro direccion';
    }
  }

  Future<String> login(String email, String password) async {
    var response = await http.post('${domain}api/v1/login',
        body: {"email": "$email", "password": "$password"});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return result['token']['token'];
    } else {
      return null;
    }
  }

  Future<bool> lectura(String token, BuildContext context) async {
    var prueba;
    var response = await http.get('http://www.gpsaseguro.com/api/v1/auth/user',
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode != 200) {
      print('ENTRO');
      return false;
    } else {
      print('ENTROvalido');
      prueba = jsonDecode(response.body);
      print(prueba['name']);
      Provider.of<ClientViewModel>(context, listen: false)
          .setclient(Cliente.fromJson(jsonDecode(response.body)));

      return true;
    }
  }

  Future<Usuario> getUser(
    String token,
  ) async {
    var cliente = Usuario();
    var response = await http.get('${domain}api/clientesgps',
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      print(response);
      var cliente = Usuario.fromJson(jsonDecode(response.body));
      print(response.body);
      return cliente;
    } else {
      print(response.body);
      return cliente;
    }
  }

  Future<List<Vehiculo>> listDevice(String _token) async {
    var response = await http.get('https://aseguroperu.com/api/dispositivosgps',
        headers: {'Authorization': 'Bearer $_token'});

    if (response.statusCode == 200) {
      var lisvehiculo = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      // ignore: omit_local_variable_types
      List<Vehiculo> listve =
          lisvehiculo.map((i) => Vehiculo.fromJson(i)).toList();
      return listve;
    } else {
      return [];
    }
  }

  Future<List<Notifications>> listNotifications(String _token) async {
    var response = await http.get('https://aseguroperu.com/api/notificaciones',
        headers: {'Authorization': 'Bearer $_token'});

    if (response.statusCode == 200) {
      var lisnotifi = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      // ignore: omit_local_variable_types
      List<Notifications> listnoti =
          lisnotifi.map((i) => Notifications.fromJson(i)).toList();
      return listnoti;
    } else {
      return [];
    }
  }

  Future<int> sendtoken(String _token, String firetoken) async {
    var response = await http.get(
        'https://aseguroperu.com/api/usertoken?Token=$firetoken',
        headers: {'Authorization': 'Bearer $_token'});

    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}
