import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsadmin/Widgets/Wvehiculos.dart';
import 'package:gpsadmin/Widgets/car_painter.dart';
import 'package:gpsadmin/models/notification.dart';
import 'package:gpsadmin/models/usuario.dart';
import 'package:gpsadmin/models/vehiculo.dart';
import 'package:gpsadmin/services/endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gpsadmin/Utils/utils.dart';

enum Statuslogin { initial, error, success }
enum StatusGPS { initialgps, gpsdesactive, permissiondesactive, successgps }

class LoginBloc extends ChangeNotifier {
  var mapStyle = [
    [
      {
        "elementType": "geometry",
        "stylers": [
          {"color": "#ebe3cd"}
        ]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [
          {"color": "#523735"}
        ]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [
          {"color": "#f5f1e6"}
        ]
      },
      {
        "featureType": "administrative",
        "elementType": "geometry.stroke",
        "stylers": [
          {"color": "#c9b2a6"}
        ]
      },
      {
        "featureType": "administrative.land_parcel",
        "elementType": "geometry.stroke",
        "stylers": [
          {"color": "#dcd2be"}
        ]
      },
      {
        "featureType": "administrative.land_parcel",
        "elementType": "labels.text.fill",
        "stylers": [
          {"color": "#ae9e90"}
        ]
      },
      {
        "featureType": "landscape.natural",
        "elementType": "geometry",
        "stylers": [
          {"color": "#dfd2ae"}
        ]
      },
      {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
          {"color": "#dfd2ae"}
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          {"color": "#93817c"}
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "geometry.fill",
        "stylers": [
          {"color": "#a5b076"}
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text.fill",
        "stylers": [
          {"color": "#447530"}
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          {"color": "#f5f1e6"}
        ]
      },
      {
        "featureType": "road.arterial",
        "elementType": "geometry",
        "stylers": [
          {"color": "#fdfcf8"}
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
          {"color": "#f8c967"}
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
          {"color": "#e9bc62"}
        ]
      },
      {
        "featureType": "road.highway.controlled_access",
        "elementType": "geometry",
        "stylers": [
          {"color": "#e98d58"}
        ]
      },
      {
        "featureType": "road.highway.controlled_access",
        "elementType": "geometry.stroke",
        "stylers": [
          {"color": "#db8555"}
        ]
      },
      {
        "featureType": "road.local",
        "elementType": "labels.text.fill",
        "stylers": [
          {"color": "#806b63"}
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "geometry",
        "stylers": [
          {"color": "#dfd2ae"}
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "labels.text.fill",
        "stylers": [
          {"color": "#8f7d77"}
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "labels.text.stroke",
        "stylers": [
          {"color": "#ebe3cd"}
        ]
      },
      {
        "featureType": "transit.station",
        "elementType": "geometry",
        "stylers": [
          {"color": "#dfd2ae"}
        ]
      },
      {
        "featureType": "water",
        "elementType": "geometry.fill",
        "stylers": [
          {"color": "#b9d3c2"}
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {"color": "#92998d"}
        ]
      }
    ]
  ];
  ui.Image image;

  ui.Image pointimage;
  StatusGPS _statusgps = StatusGPS.initialgps;
  StatusGPS get statusgps => _statusgps;
  set statusgps(StatusGPS status) {
    _statusgps = status;
    notifyListeners();
  }

  String _fechareport;
  String get fechareport => _fechareport;
  set fechareport(String f) {
    _fechareport = f;
    notifyListeners();
  }

  void selectbox(int value) {
    if (value == 1) {
      fechareport = DateTime.now().dateformantString;
      print(fechareport);
    } else {
      fechareport =
          DateTime.now().subtract(const Duration(days: 1)).dateformantString;
      print(fechareport);
    }
  }

  BsSelectBoxController select1 = BsSelectBoxController(options: [
    const BsSelectBoxOption(value: 1, text: Text('Hoy')),
    const BsSelectBoxOption(value: 2, text: Text('Ayer')),
  ]);
  TextEditingController fechare =
      TextEditingController(text: DateTime.now().datetimeformantString);
  TextEditingController horaini = TextEditingController(
      text:
          '${TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute.toString()}');

  TextEditingController horafin = TextEditingController(
      text:
          '${TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute.toString()}');

  Future<Null> init() async {
    final data = await rootBundle.load('assets/images/blanco.png');
    image = await loadImage(Uint8List.view(data.buffer));

    final data2 = await rootBundle.load('assets/images/marker.png');
    pointimage = await loadImage(Uint8List.view(data2.buffer));
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

  List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> poly = [];
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
      var p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
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

  Set<Polyline> polylinelist = {};
  Future maproute() async {
    var result = await Apis().getroute(originrout, destinationrout);
    polylinelist.add(Polyline(
        polylineId: PolylineId('2'), points: decodeEncodedPolyline(result)));
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

  List<Vehiculo> _vehiculosdrop = [];
  List<Vehiculo> get vehiculosdrop => _vehiculosdrop;
  set vehiculosdrop(List<Vehiculo> vehic) {
    _vehiculosdrop = vehic;
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
  Completer<GoogleMapController> controller = Completer();
  GoogleMapController mapcontrollereport;

  void refreshmap() {
    mapcontroller.animateCamera(CameraUpdate.newCameraPosition(
        const CameraPosition(
            target: LatLng(-8.1118, -79.0287),
            zoom: 18.0,
            bearing: 0.0,
            tilt: 45.0)));
  }

  int _estadoreport = 0;
  int get estadoreport => _estadoreport;
  set estadoreport(int e) {
    // 0 cargando
    //1 success correcto
    // 2 error o vacio
    _estadoreport = e;
    print("notiica");
    notifyListeners();
  }

  String _dispositivo = '';
  String get dispositivo => _dispositivo;
  set dispositivo(String d) {
    _dispositivo = d;
    notifyListeners();
  }

  List<Map<String, dynamic>> dockpackmap = <Map<String, dynamic>>[];
  Set<Polyline> polyline = {};
  Set<Marker> markers = {};
  List<LatLng> pointlatlot = [];
  LatLng cameralatlong;
  LatLngBounds boundmapsreport;
  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    for (var latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

///////////////
  Future<Uint8List> getBytesFromCanvas(String title, ui.Image carro) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    Paint paint = Paint();
    final rect = Rect.fromLTWH(0, 0, 100, 45);
    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(2));
    canvas.drawImage(carro, Offset(0, 60), paint);
    paint.color = Colors.black87;
    canvas.drawRRect(rRect, paint);
    final textPainter = TextPainter(
        text: TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr);

    textPainter.layout(minWidth: 0, maxWidth: 100);
    textPainter.paint(canvas, Offset(20, 0.30));
    final img = await pictureRecorder.endRecording().toImage(120, 130);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

/////////////////
  bool isLoading = true;
  Future<void> getreporte() async {
    var markerIcon = await getBytesFromCanvas('Inicio', pointimage);
    var markerIcon2 = await getBytesFromCanvas('Fin', pointimage);
    estadoreport = 0;
    dockpackmap = [];
    controller = Completer();
    pointlatlot.clear();
    markers.clear();
    //boundmapsreport = null;
    var retorna = await Apis().reportevehiculo(_token, _dispositivo,
        '$fechareport ${horaini.text}', '$fechareport ${horafin.text}');
    print(retorna);
    if (retorna == '0') {
      dockpackmap = [];
      estadoreport = 2;
    } else if (retorna == '[]') {
      dockpackmap = [];
      estadoreport = 2;
    } else {
      dockpackmap = (jsonDecode(retorna) as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
      for (var i = 0; i < dockpackmap.length; i++) {
        if (i == 0) {
          markers.add(Marker(
              markerId: MarkerId('1'),
              position: LatLng(double.parse(dockpackmap[i]['lat']),
                  double.parse(dockpackmap[i]['lng'])),
              icon: BitmapDescriptor.fromBytes(markerIcon),
              anchor: const Offset(0.3, 0.9),
              infoWindow: const InfoWindow(title: 'Inicio')));
        }

        pointlatlot.add(LatLng(double.parse(dockpackmap[i]['lat']),
            double.parse(dockpackmap[i]['lng'])));
        if (dockpackmap.length - 1 == i) {
          cameralatlong = LatLng(double.parse(dockpackmap[i]['lat']),
              double.parse(dockpackmap[i]['lng']));
          markers.add(Marker(
              markerId: MarkerId('2'),
              position: LatLng(double.parse(dockpackmap[i]['lat']),
                  double.parse(dockpackmap[i]['lng'])),
              icon: BitmapDescriptor.fromBytes(markerIcon2),
              anchor: const Offset(0.3, 0.9),
              infoWindow: const InfoWindow(title: 'Fin')));
        }
      }
      polyline.add(Polyline(
          polylineId: PolylineId('1'),
          visible: true,
          points: pointlatlot,
          color: Colors.black87,
          width: 4));

      boundmapsreport = boundsFromLatLngList(pointlatlot);
      estadoreport = 1;

      mapcontrollereport = await controller.future;

      await mapcontrollereport
          .animateCamera(CameraUpdate.newLatLngBounds(boundmapsreport, 100));
    }
  }

  String velocidad = '0';
  String senal = '0';
  Future<void> addmarker2(Vehiculo vehiculo, String lat1, String long2) async {
    // ignore: omit_local_variable_types
    double rotation = 0;
    rotation = Geolocator.bearingBetween(
        double.parse(lat1),
        double.parse(long2),
        double.parse(vehiculo.lat),
        double.parse(vehiculo.lng));
    allMarkers.add(
      Marker(
          icon: BitmapDescriptor.fromBytes(
              await myPaintcar(vehiculo.placa, image)),
          markerId: MarkerId(vehiculo.placa),
          infoWindow: InfoWindow.noText,
          draggable: true,
          anchor: const Offset(0.9, 0.5),
          rotation: rotation,
          onTap: () {
            imprime(vehiculo);
          },
          position:
              LatLng(double.parse(vehiculo.lat), double.parse(vehiculo.lng))),
    );
  }

  Future<void> addmarkerSIN15(Vehiculo vehiculo) async {
    allMarkers.clear();
    // ignore: cascade_invocations
    allMarkers.add(
      Marker(
          icon: BitmapDescriptor.fromBytes(
              await myPaintcar(vehiculo.placa, image)),
          markerId: MarkerId(vehiculo.placa),
          infoWindow: InfoWindow.noText,
          draggable: true,
          anchor: const Offset(0.9, 0.5),
          onTap: () {
            imprime(vehiculo);
          },
          position:
              LatLng(double.parse(vehiculo.lat), double.parse(vehiculo.lng))),
    );
  }

  Vehiculo _vehiculosinplaca;
  Vehiculo get vehiculosinplaca => _vehiculosinplaca;
  set vehiculosinplaca(Vehiculo v) {
    _vehiculosinplaca = v;
    notifyListeners();
  }

  LatLngBounds boundmaps;
  Future<void> getroute15() async {
    print("=========busca 15");

    polylinelist.clear();
    List<LatLng> markes = [];

    var result = await Apis().recorrido15(_token, _dispositivo);
    int numfinal = result.length - 1;
    print(result);
    // ignore: avoid_function_literals_in_foreach_calls
    if (result.length == 0) {
      // allMarkers.clear();
      print("=========INGRESA AL []");
      await addmarkerSIN15(vehiculosinplaca);
      streetview = LatLng(double.parse(vehiculosinplaca.lat),
          double.parse(vehiculosinplaca.lng));
      destinationrout = LatLng(double.parse(vehiculosinplaca.lat),
          double.parse(vehiculosinplaca.lng));
      markes.add(LatLng(double.parse((vehiculosinplaca.lat)),
          double.parse((vehiculosinplaca.lng))));
      boundmaps = boundsFromLatLngList(markes);
      await mapcontroller
          .animateCamera(CameraUpdate.newLatLngBounds(boundmaps, 100));
      notifyListeners();
      //  moveCamera(double.parse(vehiculosinplaca.lat),
      //               double.parse(vehiculosinplaca.lng), 18.0);

    } else {
      for (var i = 0; i < result.length; i++) {
        markes.add(LatLng(
            double.parse((result[i].lat)), double.parse((result[i].lng))));
        if (i == numfinal) {
          allMarkers.clear();
          await addmarker2(
              Vehiculo(
                  lat: result[i].lat,
                  lng: result[i].lng,
                  placa: result[i].placa),
              result[i - 1].lat,
              result[i - 1].lng);
          velocidad = result[i].velocidad;
          senal = result[i].intensidadSenal;
          streetview =
              LatLng(double.parse(result[i].lat), double.parse(result[i].lng));
        }
      }
      polylinelist.add(Polyline(
          polylineId: PolylineId('3'), points: markes, color: Colors.red));
      boundmaps = boundsFromLatLngList(markes);
      await mapcontroller
          .animateCamera(CameraUpdate.newLatLngBounds(boundmaps, 100));
      notifyListeners();
    }
  }

  bool _isStopped2 = false;
  bool get isStopped2 => _isStopped2;
  set isStopped2(bool i) {
    _isStopped2 = i;
    notifyListeners();
  }

  Future callapi2() async {
    print('==========LAMA AL API 15');
    Timer.periodic(const Duration(seconds: 20), (timer) async {
      if (_isStopped2) {
        timer.cancel();
      } else {
        await getroute15();
      }

      //timer.cancel();
    });
  }

  bool _isStopped = false;
  bool get isStopped => _isStopped;
  set isStopped(bool i) {
    _isStopped = i;
    notifyListeners();
  }

  LatLng _streetview;
  LatLng get streetview => _streetview;
  set streetview(LatLng s) {
    _streetview = s;
    notifyListeners();
  }

  String horaformato = DateTime.now().dateformantString;
  String _placar = '';
  String get placar => _placar;
  set placar(String d) {
    _placar = d;
    notifyListeners();
  }

  final CameraPosition kGooglePlex =
      const CameraPosition(target: LatLng(-8.1118, -79.0287), zoom: 12);
  double latNor = -1.0;
  double lngNor = -1.0;

  double latSur = 1.0;
  double lngSur = -100.0;
  LatLngBounds movecamera2;
  void moveCamera(double lat, double long, double zoom) {
    mapcontroller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, long), zoom: zoom, bearing: 0.0, tilt: 45.0)));
    // ignore: cascade_invocations

    notifyListeners();
  }

  void moveCamera2(double lat, double long, double zoom) {
    boundmaps = null;
    mapcontroller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, long), zoom: zoom, bearing: 0.0, tilt: 45.0)));
    // ignore: cascade_invocations
    mapcontrollereport
        .animateCamera(CameraUpdate.newLatLngBounds(movecamera2, 0));
    notifyListeners();
  }

  Future callapi() async {
    print('==========LAMA AL API DE CARROS');
    Timer.periodic(const Duration(seconds: 20), (timer) async {
      if (_isStopped) {
        timer.cancel();
      } else {
        await getvehiculos();
      }

      //timer.cancel();
    });
  }

  bool _modal = false;
  bool get modal => _modal;
  set modal(bool mod) {
    _modal = mod;
    notifyListeners();
  }

  bool _stylemap = false;
  bool get stylemap => _stylemap;
  set stylemap(bool s) {
    _stylemap = s;
    notifyListeners();
  }

  String totalvehiculodrop = '';
  bool cargalista = false;
  BsSelectBoxController vehiculosdroplist = BsSelectBoxController();
  Future<bool> getvehiculos() async {
    //allMarkers.clear();
    //notifyListeners();
    var option = <BsSelectBoxOption>[];
    print("========================token:" + _token);
    _vehiculos = await Apis().listDevice(_token);

    final markerIcon = await getBytesFromAsset('assets/images/blanco.png', 50);
    if (_vehiculos == []) {
      return false;
    } else {
      //allMarkers.clear();
      detenido = 0;
      enmovimiento = 0;
      apagado = 0;
      totalve = _vehiculos.length;
      totalvehiculodrop = 'Todos (${_vehiculos.length})';
      option.add(BsSelectBoxOption(
          value: Vehiculo(imei: '0', lat: '0', lng: '0', placa: '0'),
          text: Text('Todos (${_vehiculos.length})')));
      _vehiculos.forEach((element) {
        print(element.id);
        option.add(BsSelectBoxOption(
            value: Vehiculo(
                imei: element.imei,
                lat: element.lat,
                lng: element.lng,
                placa: element.placa),
            text: Text(
              element.placa,
            )));
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

        vehiculosdroplist.options = option;
        notifyListeners();
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
    notifyListeners();
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
