import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsadmin/Widgets/car_painter.dart';
import 'package:gpsadmin/models/notification.dart';
import 'package:gpsadmin/models/pointlatlong.dart';
import 'package:gpsadmin/models/usuario.dart';
import 'package:gpsadmin/models/vehiculo.dart';
import 'package:gpsadmin/services/endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Statuslogin { initial, error, success }
enum StatusGPS { initialgps, gpsdesactive, permissiondesactive, successgps }

class LoginBloc extends ChangeNotifier{
   

  ui.Image image;
  StatusGPS _statusgps = StatusGPS.initialgps;
  StatusGPS get statusgps => _statusgps;
  set statusgps(StatusGPS status) {
    _statusgps = status;
    notifyListeners();
  }

  Future<Null> init() async {
    final data = await rootBundle.load('assets/images/blanco.png');
    image = await loadImage(Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final completer = Completer<ui.Image>();
    // ignore: unnecessary_lambdas
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void getToken() async {
    print(await messaging.getToken());
  }

  List<PointLatLng> decodeEncodedPolyline(String encoded) {
    List<PointLatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      PointLatLng p =
          new PointLatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }

  Future<StatusGPS> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return StatusGPS.gpsdesactive;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return StatusGPS.permissiondesactive;
      } else {
        return StatusGPS.successgps;
      }
    } else {
      return StatusGPS.successgps;
    }
  }

  Future<int> locationGPS() async {
    var estado = 0;
    var status = await _determinePosition();
    switch (status) {
      case StatusGPS.gpsdesactive:
        estado = 1;
        break;
      case StatusGPS.permissiondesactive:
        estado = 2;
        break;
      case StatusGPS.successgps:
        estado = 3;
        break;
      default:
    }
    return estado;
  }

  LatLng originrout;
  LatLng destinationrout = LatLng(0, 0);

  List<PointLatLng> polylinelist = [];
  Future maproute() async {
    var result = await Apis().getroute(originrout, destinationrout);
    polylinelist = decodeEncodedPolyline(result);
    notifyListeners();
  }

  Future getposition() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    originrout = LatLng(position.latitude, position.longitude);
    await maproute();
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  List<Vehiculo> _vehiculos = [];
  List<Vehiculo> get vehiculos => _vehiculos;
  set vehiculos(List<Vehiculo> vehic) {
    _vehiculos = vehic;
    notifyListeners();
  }

  bool _loadingnoti = false;
  bool get loadingnoti => _loadingnoti;
  set loadingnoti(bool load) {
    _loadingnoti = load;
    notifyListeners();
  }

  List<Notifications> notifications = [];

  Future getnotification() async {
    print('======BUSCA NOTIRFICACIONES');
    loadingnoti = false;
    notifications = await Apis().listNotifications(_token);
    notifyListeners();
    loadingnoti = true;
  }

  String _token = '';
  String get token => _token;
  set token(String tok) {
    _token = tok;
    notifyListeners();
  }

  void gettoken() async {
    // ignore: omit_local_variable_types
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // ignore: omit_local_variable_types
    _token = sharedPreferences.getString('tokenuser') ?? '';
    if (_token != '') {
      await getclient(_token);
    }
  }

  Statuslogin _statuslogin = Statuslogin.initial;
  Statuslogin get statuslogin => _statuslogin;
  Usuario _usuario = Usuario();
  Usuario get usuario => _usuario;
  set usuario(Usuario cli) {
    _usuario = cli;
    notifyListeners();
  }

  set statuslogin(Statuslogin st) {
    _statuslogin = st;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool status) {
    _loading = status;
    notifyListeners();
  }

  void initlogin() {
    statuslogin = Statuslogin.initial;
    notifyListeners();
  }

  int _apagado = 0;
  int get apagado => _apagado;
  set apagado(int ap) {
    _apagado = ap;
    notifyListeners();
  }

  int _detenido = 0;
  int get detenido => _detenido;
  set detenido(int det) {
    _detenido = det;
    notifyListeners();
  }

  int _enmovimiento = 0;
  int get enmovimiento => _enmovimiento;
  set enmovimiento(int enmo) {
    _enmovimiento = enmo;
    notifyListeners();
  }

  int _totalve = 0;
  int get totalve => _totalve;
  set totalve(int tot) {
    _totalve = tot;
    notifyListeners();
  }

  bool _visible = false;
  bool get visible => _visible;
  set visible(bool vis) {
    _visible = vis;
    notifyListeners();
  }

  Future<Uint8List> myPaintcar(String label, ui.Image ima) async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    CarPainter carpainter = CarPainter(label, ima);
    carpainter.paint(canvas, Size(130, 50));
    final ui.Image image = await recorder.endRecording().toImage(150, 160);
    final ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  Future<Statuslogin> login() async {
    loading = true;
    var result = await Apis().login(email.text, password.text);
    if (result == null) {
      loading = false;
      return statuslogin = Statuslogin.error;
    } else {
      token = result;
      var res = await getclient(_token);
      // ignore: omit_local_variable_types
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('tokenuser', _token);
      await sharedPreferences.setBool('loginactive', true);
      if (res == true) {
        gettoken();
        var firetoke = await messaging.getToken();
        await Apis().sendtoken(_token, firetoke);
        loading = false;
        return statuslogin = Statuslogin.success;
      } else {
        loading = false;
        return statuslogin = Statuslogin.error;
      }
    }
  }

  Future<bool> getclient(String toke) async {
    var result = await Apis().getUser(toke);
    if (result == null) {
      usuario = Usuario();
      return false;
    } else {
      usuario = result;
      var cod = await getvehiculos();
      if (cod == true) {
        return true;
      } else {
        return false;
      }
      //return true;
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    var data = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    var fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  List<Marker> allMarkers = <Marker>[];
  double zoom = 11.8;
  GoogleMapController mapcontroller;

  void refreshmap() {
    mapcontroller.animateCamera(CameraUpdate.newCameraPosition(
        const CameraPosition(
            target: LatLng(-8.1118, -79.0287),
            zoom: 18.0,
            bearing: 0.0,
            tilt: 45.0)));
  }

  final CameraPosition kGooglePlex =
      const CameraPosition(target: LatLng(-8.1118, -79.0287), zoom: 12);
  double latNor = -1.0;
  double lngNor = -1.0;

  double latSur = 1.0;
  double lngSur = -100.0;
  void moveCamera(double lat, double long) {
    mapcontroller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, long), zoom: 18.0, bearing: 0.0, tilt: 45.0)));
    // ignore: cascade_invocations

    notifyListeners();
  }

  Future callapi() async {
    print('==========LAMA AL API DE CARROS');
    Timer.periodic(const Duration(seconds: 20), (timer) async {
      await getvehiculos();

      //timer.cancel();
    });
  }

  bool _modal = false;
  bool get modal => _modal;
  set modal(bool mod) {
    _modal = mod;
    notifyListeners();
  }

  bool cargalista = false;
  Future<bool> getvehiculos() async {
    //print("========================token:" + _token);
    _vehiculos = await Apis().listDevice(_token);

    final markerIcon = await getBytesFromAsset('assets/images/blanco.png', 50);
    if (_vehiculos == []) {
      return false;
    } else {
      detenido = 0;
      enmovimiento = 0;
      apagado = 0;
      totalve = _vehiculos.length;
      _vehiculos.forEach((element) {
        var revisa = element.movimiento; //aqui cunto los estados 1 x 1
        switch (revisa) {
          case 'Movimiento':
            enmovimiento = _enmovimiento + 1;
            break;
          case 'Sin Movimiento':
            detenido = _detenido + 1;
            break;
          case 'Apagado':
            apagado = _apagado + 1;
            break;
        }
        //var readLines = ['Dart is fun', 'It is easy to learn'];
        addmarker(element);
      });
      cargalista = true;
      notifyListeners();
      return true;
    }
  }

  Future<void> addmarker(Vehiculo vehiculo) async {
    var bytes = await myPaintcar(vehiculo.placa, image);
    allMarkers.add(
      Marker(
          icon: BitmapDescriptor.fromBytes(bytes),
          markerId: MarkerId(vehiculo.placa),
          infoWindow: InfoWindow.noText,
          draggable: true,
          onTap: () {
            imprime(vehiculo);
          },
          position:
              LatLng(double.parse(vehiculo.lat), double.parse(vehiculo.lng))),
    );
  }

  bool visibledi = false;
  String placa = '';
  String direccion = '';
  void imprime(Vehiculo vehiculo) async {
    placa = vehiculo.placa;
    visibledi = true;
    notifyListeners();
    await extracdirection(vehiculo.lat, vehiculo.lng);
    // print(vehiculo.placa);
  }

  Future extracdirection(String latitude, String longitude) async {
    direccion = await Apis().getdirection(latitude, longitude);
    notifyListeners();
  }

  void changuevisibledi() {
    visibledi = false;
    notifyListeners();
  }
}
